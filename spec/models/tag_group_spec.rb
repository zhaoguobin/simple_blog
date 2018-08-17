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
end
