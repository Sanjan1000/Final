class NestedPostsController < ApplicationController
  before_action :find_post
  before_action :set_post
  before_action :set_nested_post, only: [:edit, :update, :destroy]

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
  
  def edit
  end
  def update
    if @nested_post.update(nested_post_params)
      redirect_to post_path(@post), notice: 'Nested post was successfully updated.'
    else
      render :edit
    end
  end
  def destroy
    @nested_post.destroy
    redirect_to post_path(@post), notice: 'Nested post was successfully destroyed.'
  end
  private

  def find_post
    @post = Post.find(params[:post_id])
  end
  def set_post
    @post = Post.find(params[:post_id])
  end
  def set_nested_post
    @nested_post = @post.nested_posts.find(params[:id])
  end

  def nested_post_params
    params.require(:nested_post).permit(:title, :body)
  end
end

