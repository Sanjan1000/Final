class NestedPost < ApplicationRecord
  enum topic: { books: 0, signs: 1, silverware: 2, other: 3 }
  belongs_to :post
  belongs_to :user
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
end
