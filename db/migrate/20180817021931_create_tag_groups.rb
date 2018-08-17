class CreateTagGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_groups do |t|
      t.string :name
      t.string :slug, null: false
      t.integer :tags_count, default: 0, null: false

      t.timestamps
    end
    add_index :tag_groups, :slug
  end
end
