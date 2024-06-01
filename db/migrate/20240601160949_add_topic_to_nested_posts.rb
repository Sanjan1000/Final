class AddTopicToNestedPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :nested_posts, :topic, :integer
  end
end
