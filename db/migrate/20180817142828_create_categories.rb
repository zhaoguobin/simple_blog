class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug, null: false
      t.string :avatar
      t.string :description
      t.integer :articles_count, default: 0, null: false

      t.timestamps
    end
    add_index :categories, :slug
  end
end
