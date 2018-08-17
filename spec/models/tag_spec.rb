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
end
