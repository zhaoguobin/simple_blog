FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "tag #{n}" }
    tag_group
  end
end
