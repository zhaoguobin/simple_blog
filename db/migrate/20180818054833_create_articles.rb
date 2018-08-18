class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug, null: false
      t.string :avatar
      t.text :abstract
      t.text :body
      t.text :body_html
      t.text :body_toc
      t.integer :category_id
      t.datetime :published_at

      t.timestamps
    end
    add_index :articles, :slug
    add_index :articles, :published_at
  end
end
