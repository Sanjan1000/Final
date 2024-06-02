class Post < ApplicationRecord
  enum topic: { books: 0, signs: 1, silverware: 2, other: 3 }
  belongs_to :user
  has_many :nested_posts, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # Add any necessary validations
  validates :integer_field1, :integer_field2, :integer_field3, numericality: { only_integer: true }, allow_nil: true
  validates :string_field1, :string_field2, :string_field3, length: { maximum: 255 }, allow_nil: true
  validates :boolean_field1, :boolean_field2, :boolean_field3, inclusion: { in: [true, false] }, allow_nil: true
  validates :date_field1, :date_field2, :date_field3, presence: true, allow_nil: true

  # Ransacker for title or body search
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
