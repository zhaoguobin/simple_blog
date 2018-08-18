require 'rails_helper'

RSpec.describe Category, type: :model do
  it "is valid with a name" do
    category = Category.new(name: 'test_category')
    expect(category).to be_valid
  end

  it "is invalid without a name" do
    category = Category.new(name: nil)
    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    Category.create(name: 'test_category')
    category = Category.new(name: 'test_category')
    category.valid?
    expect(category.errors[:name]).to include("has already been taken")
  end

  it "has many articles" do
    category = Category.create(name: 'test_category')
    article = Article.create(title: 'test_article', category_id: category.id)
    expect(category.articles).to include(article)
    expect(category.reload.articles_count).to eq 1
  end

  it "will delete its articles when it is deleted" do
    category = Category.create(name: 'test_category')
    Article.create(title: 'test_article', category_id: category.id)
    expect {
      category.destroy
    }.to change(Article.all, :count).by(-1)
  end
end
