class NestedPostsController < ApplicationController
  before_action :find_post

  def new
    @nested_post = @post.nested_posts.build
  end

  def create
    @nested_post = @post.nested_posts.build(nested_post_params)
    if @nested_post.save
      redirect_to @post, notice: 'Item was successfully created.'
    else
      render :new
    end
  end
  
  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def nested_post_params
    params.require(:nested_post).permit(:title, :body)
  end
end

