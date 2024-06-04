class CreateTagsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end