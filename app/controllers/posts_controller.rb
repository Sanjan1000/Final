class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:edit, :update, :destroy]

  def index
    if current_user.admin?
      @posts = Post.all.order("created_at DESC")
    else
      @posts = current_user.posts.order("created_at DESC")
    end
  end

  def show
    @post = Post.find(params[:id])
    @nested_post = NestedPost.new(post: @post)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    if current_user.admin?
      @post = Post.find(params[:id])
    else
      @post = current_user.posts.find(params[:id])
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Post not found."
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
