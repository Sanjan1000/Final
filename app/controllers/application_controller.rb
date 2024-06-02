class ApplicationController < ActionController::Base
  before_action :set_query
  def set_query
    @query = Post.ransack(params[:q])
  end

  def update_theme
    if current_user.present?
      ApplicationRecord.update_user_theme(current_user, params[:theme])
      render json: { status: 'ok' }
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end
end
