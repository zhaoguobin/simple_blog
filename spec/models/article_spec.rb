require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @category = Category.create(name: 'category 1')
  end

  it "is valid with a title" do
    article = Article.new(title: 'test_article', category_id: @category.id)
    expect(article).to be_valid
  end

  it "is invalid without a title" do
    article = Article.new(title: nil, category_id: @category.id)
    article.valid?
    expect(article.errors[:title]).to include("can't be blank")
  end

  it "is invalid with a duplicate title" do
    Article.create(title: 'test_article', category_id: @category.id)
    article = Article.new(title: 'test_article', category_id: @category.id)
    article.valid?
    expect(article.errors[:title]).to include("has already been taken")
  end

  it "belongs to a category" do
    article = Article.create(title: 'test_article', category_id: @category.id)
    expect(article.category).to eq @category
  end

  it "has many and belongs to tags" do
    tag_group = TagGroup.create(name: 'test tag group')
    tag = Tag.create(name: 'test tag', tag_group_id: tag_group.id)
    article = Article.create(title: 'test_article', category_id: @category.id, tag_ids: [tag.id])
    expect(article.tags).to include(tag)
  end

  it "returns published articles" do
    unpublished_article = Article.create(title: 'unpublished_article', category_id: @category.id, published_at: nil)
    published_article1 = Article.create(title: 'published_article1', category_id: @category.id, published_at: 1.hour.ago)
    published_article2 = Article.create(title: 'published_article2', category_id: @category.id, published_at: Time.now)
    expect(Article.published).to eq [published_article2, published_article1]
  end

  context "published? method" do
    it "return true if its published_at is present" do
      article = Article.create(title: 'test_article', category_id: @category.id, published_at: Time.now)
      expect(article.published?).to be true
    end

    it "return false if its published_at is blank" do
      article = Article.create(title: 'test_article', category_id: @category.id, published_at: nil)
      expect(article.published?).to be false
    end
  end

  it "has a publshed time after be published" do
    article = Article.create(title: 'test_article', category_id: @category.id, published_at: nil)
    article.publish
    expect(article.published_at).not_to be nil
  end

  it "doesn't have a publshed time after be unpublished" do
    article = Article.create(title: 'test_article', category_id: @category.id, published_at: Time.now)
    article.unpublish
    expect(article.published_at).to be nil
  end

  it "updates body_html and body_toc automatically when updates body" do
    article = Article.create(title: 'test_article', category_id: @category.id, body: "## head 1\n## head 2\n")
    expect(article.body_html).to eq "<h2 id=\"head-1\">head 1</h2>\n\n<h2 id=\"head-2\">head 2</h2>\n"
    expect(article.body_toc).to eq "<ul>\n<li>\n<a href=\"#head-1\">head 1</a>\n</li>\n<li>\n<a href=\"#head-2\">head 2</a>\n</li>\n</ul>\n"
  end

end
