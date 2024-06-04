class CreateTaggablesTable < ActiveRecord::Migration[7.1]
  def change
    create_table :taggables do |t|
      t.integer :nested_post_id, null: false
      t.integer :tag_id, null: false
      t.timestamps null: false

      t.index ["nested_post_id"], name: "index_taggables_on_nested_post_id"
      t.index ["tag_id"], name: "index_taggables_on_tag_id"
    end
  end
end
