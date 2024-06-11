class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:edit, :update, :destroy]

  def index
    @posts = current_user.admin? ? Post.all.order("created_at DESC") : current_user.posts.order("created_at DESC")
    @jira_tickets = JiraService.new(current_user).fetch_tickets
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
    @post = current_user.admin? ? Post.find(params[:id]) : current_user.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Post not found."
  end

  def post_params
    params.require(:post).permit(:title, :body, :topic, :integer_field1, :integer_field2, :integer_field3, :string_field1, :string_field2, :string_field3, :multiline_text1, :multiline_text2, :multiline_text3, :boolean_field1, :boolean_field2, :boolean_field3, :date_field1, :date_field2, :date_field3, :boolean_field1_text, :boolean_field2_text, :boolean_field3_text)
  end
end
