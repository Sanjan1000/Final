class CreateCommentsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :name
      t.text :body
      t.integer :nested_post_id
      t.timestamps null: false

      t.index ["nested_post_id"], name: "index_comments_on_nested_post_id"
    end
  end
end
