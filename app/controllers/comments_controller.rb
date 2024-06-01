class CommentsController < ApplicationController
  before_action :find_nested_post

  def create
    @nested_post = NestedPost.find(params[:nested_post_id])
    @comment = @nested_post.comments.create(comment_params)
    redirect_to post_nested_post_path(@nested_post.post, @nested_post)
  end

  def destroy
    @nested_post = NestedPost.find(params[:nested_post_id])
    @comment = @nested_post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_nested_post_path(@nested_post.post, @nested_post)
  end

  private

  def find_nested_post
    @nested_post = NestedPost.find(params[:nested_post_id])
  end

  def comment_params
    params.require(:comment).permit(:name, :body)
  end
end
