FactoryBot.define do
  factory :post do
    body { "MyText" }
    upvote { 1 }
    downvote { 1 }
    user { association :user }

    trait :invalid do
      body { nil }
    end

    factory :empty_post, traits: [:invalid]
  end
end
