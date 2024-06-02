class AddExtraFieldsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :integer_field1, :integer
    add_column :posts, :integer_field2, :integer
    add_column :posts, :integer_field3, :integer
    add_column :posts, :string_field1, :string
    add_column :posts, :string_field2, :string
    add_column :posts, :string_field3, :string
    add_column :posts, :multiline_text1, :text
    add_column :posts, :multiline_text2, :text
    add_column :posts, :multiline_text3, :text
    add_column :posts, :boolean_field1, :boolean
    add_column :posts, :boolean_field2, :boolean
    add_column :posts, :boolean_field3, :boolean
    add_column :posts, :date_field1, :date
    add_column :posts, :date_field2, :date
    add_column :posts, :date_field3, :date
  end
end
