class Post < ApplicationRecord
  has_many :comments
  has_many :nested_posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
end
