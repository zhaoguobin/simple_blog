require 'rails_helper'

RSpec.describe Tag, type: :model do
  
  it "is valid with a name" do
    tag = FactoryBot.build(:tag, name: 'test_tag')
    expect(tag).to be_valid
  end

  it "is invalid without a name" do
    tag = FactoryBot.build(:tag, name: nil)
    tag.valid?
    expect(tag.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    FactoryBot.create(:tag, name: 'test_tag')
    tag = FactoryBot.build(:tag, name: 'test_tag')
    tag.valid?
    expect(tag.errors[:name]).to include("has already been taken")
  end

  it "belongs to a tag group" do
    tag_group = FactoryBot.create(:tag_group)
    tag = FactoryBot.create(:tag, tag_group_id: tag_group.id)
    expect(tag.tag_group).to eq tag_group
  end

  it "has many and belongs to articles" do
    tag = FactoryBot.create(:tag)
    article = FactoryBot.create(:article, tag_ids: [tag.id])
    expect(tag.articles).to include(article)
  end

  it "returns hot articles" do
    tag1 = FactoryBot.create(:tag)
    tag2 = FactoryBot.create(:tag)
    FactoryBot.create(:article, tag_ids: [tag1.id])
    FactoryBot.create(:article, tag_ids: [tag2.id])
    FactoryBot.create(:article, tag_ids: [tag2.id])
    expect(Tag.hot).to eq [tag2, tag1]
    expect(Tag.hot(1)).to eq [tag2]
  end

  it "returns published articles" do
    tag = FactoryBot.create(:tag)
    unpublished_article = FactoryBot.create(:article, :unpublished, tag_ids: [tag.id])
    published_article1 = FactoryBot.create(:article, :published_yesterday, tag_ids: [tag.id])
    published_article2 = FactoryBot.create(:article, :published_now, tag_ids: [tag.id])
    expect(tag.published_articles).to eq [published_article2, published_article1]
  end
  
end
