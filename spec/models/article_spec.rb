require 'rails_helper'

RSpec.describe Article, type: :model do

  it "is valid with a title" do
    article = FactoryBot.build(:article, title: 'test_article')
    expect(article).to be_valid
  end

  it "is invalid without a title" do
    article = FactoryBot.build(:article, title: nil)
    article.valid?
    expect(article.errors[:title]).to include("can't be blank")
  end

  it "is invalid with a duplicate title" do
    FactoryBot.create(:article, title: 'test_article')
    article = FactoryBot.build(:article, title: 'test_article')
    article.valid?
    expect(article.errors[:title]).to include("has already been taken")
  end

  it "belongs to a category" do
    category = FactoryBot.create(:category)
    article = FactoryBot.create(:article, category_id: category.id)
    expect(article.category).to eq category
  end

  it "has many and belongs to tags" do
    tag = FactoryBot.create(:tag)
    article = FactoryBot.create(:article, tag_ids: [tag.id])
    expect(article.tags).to include(tag)
  end

  it "increment/decrement articles_count of tags when add/remove tags" do
    tag = FactoryBot.create(:tag)
    count_before_add = tag.articles_count
    article = FactoryBot.create(:article, tag_ids: [tag.id])
    count_after_add = tag.reload.articles_count
    expect(count_after_add - count_before_add).to eq 1
    article.tags.delete(tag)
    count_after_remove = tag.reload.articles_count
    expect(count_after_remove - count_after_add).to eq -1
  end

  it "decrement articles_count of tags when it is deleted" do
    tag = FactoryBot.create(:tag)
    article = FactoryBot.create(:article, tag_ids: [tag.id])
    count_after_add = tag.reload.articles_count
    article.destroy
    count_after_destroy = tag.reload.articles_count
    expect(count_after_destroy - count_after_add).to eq -1
  end

  it "returns published articles" do
    unpublished_article = FactoryBot.create(:article, :unpublished)
    published_article1 = FactoryBot.create(:article, :published_yesterday)
    published_article2 = FactoryBot.create(:article, :published_now)
    expect(Article.published).to eq [published_article2, published_article1]
  end

  context "published? method" do
    it "return true if its published_at is present" do
      article = FactoryBot.create(:article, :published_now)
      expect(article.published?).to be true
    end

    it "return false if its published_at is blank" do
      article = FactoryBot.create(:article, :unpublished)
      expect(article.published?).to be false
    end
  end

  it "has a publshed time after be published" do
    article = FactoryBot.create(:article, :unpublished)
    article.publish
    expect(article.published_at).not_to be nil
  end

  it "doesn't have a publshed time after be unpublished" do
    article = FactoryBot.create(:article, :published_now)
    article.unpublish
    expect(article.published_at).to be nil
  end

  it "updates body_html and body_toc automatically when updates body" do
    article = FactoryBot.create(:article, body: "## head 1\n## head 2\n")
    expect(article.body_html).to eq "<h2 id=\"head-1\">head 1</h2>\n\n<h2 id=\"head-2\">head 2</h2>\n"
    expect(article.body_toc).to eq "<ul>\n<li>\n<a href=\"#head-1\">head 1</a>\n</li>\n<li>\n<a href=\"#head-2\">head 2</a>\n</li>\n</ul>\n"
  end

end
