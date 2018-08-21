FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "article #{n}" }
    category
    
    trait :unpublished do
      published_at { nil }
    end

    trait :published_now do
      published_at { Time.now }
    end

    trait :published_yesterday do
      published_at { 1.day.ago }
    end
  end
end
