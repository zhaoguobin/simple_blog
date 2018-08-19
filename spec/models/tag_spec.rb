require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag_group = TagGroup.create(name: 'tag group 1')
  end

  it "is valid with a name" do
    tag = Tag.new(name: 'test_tag', tag_group_id: @tag_group.id)
    expect(tag).to be_valid
  end

  it "is invalid without a name" do
    tag = Tag.new(name: nil, tag_group_id: @tag_group.id)
    tag.valid?
    expect(tag.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    Tag.create(name: 'test_tag', tag_group_id: @tag_group.id)
    tag = Tag.new(name: 'test_tag', tag_group_id: @tag_group.id)
    tag.valid?
    expect(tag.errors[:name]).to include("has already been taken")
  end

  it "belongs to a tag group" do
    tag = Tag.create(name: 'test_tag', tag_group_id: @tag_group.id)
    expect(tag.tag_group).to eq @tag_group
  end

  it "has many and belongs to articles" do
    tag = Tag.create(name: 'test tag', tag_group_id: @tag_group.id)
    category = Category.create(name: 'test category')
    article = Article.create(title: 'test_article', category_id: category.id, tag_ids: [tag.id])
    expect(tag.articles).to include(article)
  end

  it "returns published articles" do
    tag = Tag.create(name: 'test tag', tag_group_id: @tag_group.id)
    category = Category.create(name: 'test_category')
    unpublished_article = Article.create(title: 'unpublished_article', category_id: category.id, tag_ids: [tag.id], published_at: nil)
    published_article1 = Article.create(title: 'published_article1', category_id: category.id, tag_ids: [tag.id], published_at: 1.hour.ago)
    published_article2 = Article.create(title: 'published_article2', category_id: category.id, tag_ids: [tag.id], published_at: Time.now)
    expect(tag.published_articles).to eq [published_article2, published_article1]
  end
  
end
