require 'rails_helper'

RSpec.describe TagGroup, type: :model do
  it "is valid with a name" do
    tag_group = TagGroup.new(name: 'test_tag_group')
    expect(tag_group).to be_valid
  end

  it "is invalid without a name" do
    tag_group = TagGroup.new(name: nil)
    tag_group.valid?
    expect(tag_group.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    TagGroup.create(name: 'test_tag_group')
    tag_group = TagGroup.new(name: 'test_tag_group')
    tag_group.valid?
    expect(tag_group.errors[:name]).to include("has already been taken")
  end

  it "has many tags" do
    tag_group = TagGroup.create(name: 'test_tag_group')
    tag = Tag.create(name: 'test_tag', tag_group_id: tag_group.id)
    expect(tag_group.tags).to include(tag)
    expect(tag_group.reload.tags_count).to eq 1
  end

  it "will delete its tags when it is deleted" do
    tag_group = TagGroup.create(name: 'test_tag_group')
    Tag.create(name: 'test_tag', tag_group_id: tag_group.id)
    expect {
      tag_group.destroy
    }.to change(Tag.all, :count).by(-1)
  end
end
