class AddForeignKeys < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key "comments", "nested_posts"
    add_foreign_key "likes", "nested_posts"
    add_foreign_key "likes", "users"
    add_foreign_key "nested_posts", "posts"
    add_foreign_key "taggables", "nested_posts"
    add_foreign_key "taggables", "tags"
  end
end
