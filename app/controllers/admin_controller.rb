class AdminController < ApplicationController
  before_action :set_user, only: [:update, :destroy, :block, :unblock]
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @users = User.all
  end

  def update
    if @user.update(user_params)
      redirect_to admin_index_path, notice: 'User was successfully updated.'
    else
      redirect_to admin_index_path, alert: 'Unable to update user.'
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_index_path, notice: 'User was successfully deleted.'
  end

  def block
    if @user.update(blocked: true)
      redirect_to admin_index_path, notice: 'User was successfully blocked.'
    else
      redirect_to admin_index_path, alert: 'Unable to block user.'
    end
  end

  def unblock
    if @user.update(blocked: false)
      redirect_to admin_index_path, notice: 'User was successfully unblocked.'
    else
      redirect_to admin_index_path, alert: 'Unable to unblock user.'
    end
  end


  private

  def authorize_admin!
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:role, :blocked)
  end

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to admin_index_path, alert: 'User not found.' if @user.nil?
  end
end
