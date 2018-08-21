FactoryBot.define do
  factory :tag_group do
    sequence(:name) { |n| "tag group #{n}" }
  end
end
