class Post < ApplicationRecord
  has_many :comments
  has_many :nested_posts, dependent: :destroy
end
