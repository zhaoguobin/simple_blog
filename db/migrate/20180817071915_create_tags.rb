class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :slug, null: false
      t.string :avatar
      t.string :description
      t.integer :tag_group_id
      t.integer :articles_count, default: 0, null: false

      t.timestamps
    end
    add_index :tags, :slug
  end
end
