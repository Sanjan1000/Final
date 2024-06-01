class ChangeCommentsAndLikesToBelongToNestedPosts < ActiveRecord::Migration[7.1]
  def change
    remove_reference :comments, :post, foreign_key: true
    add_reference :comments, :nested_post, foreign_key: true

    remove_reference :likes, :post, foreign_key: true
    add_reference :likes, :nested_post, foreign_key: true
  end
end
