class Post < ApplicationRecord
  enum topic: { books: 0, signs: 1, silverware: 2, other: 3 }
  belongs_to :user
  has_many :nested_posts, dependent: :destroy

  has_many :liked_users, through: :likes, source: :user

  ransacker :title_or_body_cont, formatter: proc { |v| v } do |parent|
    Arel::Nodes::Grouping.new(
      parent.table[:title].matches("%#{parent.bind}%").or(parent.table[:body].matches("%#{parent.bind}%"))
    )
  end

  def self.ransackable_attributes(auth_object = nil)
    super + ["title_or_body_cont"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end