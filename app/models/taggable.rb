class Taggable < ApplicationRecord
  belongs_to :nested_post
  belongs_to :tag
end
