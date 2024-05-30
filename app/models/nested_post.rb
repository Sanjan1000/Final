class NestedPost < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables
end
