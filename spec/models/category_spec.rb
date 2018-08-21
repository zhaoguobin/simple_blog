require 'rails_helper'

RSpec.describe Category, type: :model do
  it "is valid with a name" do
    category = FactoryBot.build(:category, name: 'test_category')
    expect(category).to be_valid
  end

  it "is invalid without a name" do
    category = FactoryBot.build(:category, name: nil)
    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    FactoryBot.create(:category, name: 'test_category')
    category = FactoryBot.build(:category, name: 'test_category')
    category.valid?
    expect(category.errors[:name]).to include("has already been taken")
  end

  it "has many articles" do
    category = FactoryBot.create(:category)
    article = FactoryBot.create(:article, category_id: category.id)
    expect(category.articles).to include(article)
    expect(category.reload.articles_count).to eq 1
  end

  it "will delete its articles when it is deleted" do
    category = FactoryBot.create(:category)
    FactoryBot.create(:article, category_id: category.id)
    expect {
      category.destroy
    }.to change(Article.all, :count).by(-1)
  end

  it "returns published articles" do
    category = FactoryBot.create(:category)
    unpublished_article = FactoryBot.create(:article, :unpublished, category_id: category.id)
    published_article1 = FactoryBot.create(:article, :published_yesterday, category_id: category.id)
    published_article2 = FactoryBot.create(:article, :published_now, category_id: category.id)
    expect(category.published_articles).to eq [published_article2, published_article1]
  end

end
