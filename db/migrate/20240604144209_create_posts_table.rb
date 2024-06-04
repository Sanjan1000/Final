class CreatePostsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.integer :topic
      t.integer :integer_field1
      t.integer :integer_field2
      t.integer :integer_field3
      t.string :string_field1
      t.string :string_field2
      t.string :string_field3
      t.text :multiline_text1
      t.text :multiline_text2
      t.text :multiline_text3
      t.boolean :boolean_field1
      t.boolean :boolean_field2
      t.boolean :boolean_field3
      t.date :date_field1
      t.date :date_field2
      t.date :date_field3
      t.string :boolean_field1_text
      t.string :boolean_field2_text
      t.string :boolean_field3_text
      t.timestamps null: false
    end
  end
end