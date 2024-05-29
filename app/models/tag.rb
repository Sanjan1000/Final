class Tag < ApplicationRecord
  has_many :taggables, dependent: :destroy
  has_many :nested_posts, through: :taggables
end
