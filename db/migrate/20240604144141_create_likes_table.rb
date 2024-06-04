class CreateLikesTable < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :nested_post_id
      t.timestamps null: false

      t.index ["nested_post_id"], name: "index_likes_on_nested_post_id"
      t.index ["user_id"], name: "index_likes_on_user_id"
    end
  end
end
