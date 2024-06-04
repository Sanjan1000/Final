class CreateNestedPostsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :nested_posts do |t|
      t.string :title
      t.text :body
      t.integer :post_id, null: false
      t.integer :user_id
      t.timestamps null: false

      t.index ["post_id"], name: "index_nested_posts_on_post_id"
    end
  end
end
