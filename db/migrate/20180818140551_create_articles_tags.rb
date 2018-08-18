class CreateArticlesTags < ActiveRecord::Migration[5.2]
  def change
    create_table :articles_tags, id: false do |t|
      t.belongs_to :article, index: true
      t.belongs_to :tag, index: true
    end
    add_index :tags, :tag_group_id
    add_index :articles, :category_id
  end
end
