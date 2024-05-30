class HomeController < ApplicationController
  def index
    @latest_items = NestedPost.order(created_at: :desc).limit(10)
    @top_posts = Post.left_joins(:nested_posts).group(:id).order('COUNT(nested_posts.id) DESC').limit(5)
    @tags = Tag.joins(:taggables).group(:id).order('COUNT(taggables.tag_id) DESC')
  end
end
