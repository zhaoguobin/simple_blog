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
end
