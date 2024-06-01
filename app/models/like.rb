class Like < ApplicationRecord
  belongs_to :user
  belongs_to :nested_post
  validates :user_id, uniqueness: { scope: :nested_post_id }
end