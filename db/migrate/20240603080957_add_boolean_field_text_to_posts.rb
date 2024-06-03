class AddBooleanFieldTextToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :boolean_field1_text, :string
    add_column :posts, :boolean_field2_text, :string
    add_column :posts, :boolean_field3_text, :string
  end
end
