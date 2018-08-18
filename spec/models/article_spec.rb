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

end
