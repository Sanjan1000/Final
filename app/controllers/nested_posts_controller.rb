class NestedPostsController < ApplicationController
 
  before_action :find_post
  before_action :set_nested_post, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def show
    @nested_post = NestedPost.find(params[:id])
    @comments = @nested_post.comments.order(created_at: :desc)
  end

  def new
    @nested_post = @post.nested_posts.build
  end

  def create
    @nested_post = @post.nested_posts.build(nested_post_params.except(:tags))
    @nested_post.user = current_user
    update_nested_post_tags(@nested_post, params[:nested_post][:tags])

    if @nested_post.save
      redirect_to post_nested_post_path(@post, @nested_post), notice: 'Item was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    update_nested_post_tags(@nested_post, params[:nested_post][:tags])

    if @nested_post.update(nested_post_params.except(:tags))
      redirect_to post_nested_post_path(@post, @nested_post), notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @nested_post.destroy
    redirect_to post_path(@post), notice: 'Nested post was successfully destroyed.'
  end

  private

  def authorize_user!
    redirect_to post_path(@post), alert: 'You are not authorized to perform this action.' unless @nested_post.user == current_user || current_user.admin?
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def set_nested_post
    @nested_post = @post.nested_posts.find(params[:id])
  end

  def update_nested_post_tags(nested_post, tags)
    nested_post.tags.clear
    tags.strip.split(',').each do |tag|
      nested_post.tags << Tag.find_or_create_by(name: tag)
    end
  end

  def nested_post_params
    params.require(:nested_post).permit(:title, :body, :topic, :tags)
  end
end
