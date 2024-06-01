class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_nested_post

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @nested_post.likes.create(user_id: current_user.id)
    end
    redirect_to post_nested_post_path(@nested_post.post, @nested_post)
  end

  def destroy
    if !already_liked?
      flash[:notice] = "Cannot unlike"
    else
      @like = @nested_post.likes.find_by(user_id: current_user.id)
      @like.destroy
    end
    redirect_to post_nested_post_path(@nested_post.post, @nested_post)
  end

  private

  def find_nested_post
    @nested_post = NestedPost.find(params[:nested_post_id])
  end

  def already_liked?
    @nested_post.likes.where(user_id: current_user.id).exists?
  end
end
