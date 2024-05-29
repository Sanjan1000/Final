class NestedPost < ApplicationRecord
  belongs_to :post
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables
end
