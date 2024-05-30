class AddUserIdToNestedPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :nested_posts, :user_id, :integer
  end
end
