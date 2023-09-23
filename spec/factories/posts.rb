FactoryBot.define do
  factory :post do
    body { "MyText" }
    upvote { 1 }
    downvote { 1 }
    user { association :user }

    trait :invalid do
      body { nil }
    end

    trait :invalid_input do
      body { 'some text' }
    end

    factory :empty_post, traits: [:invalid]
    factory :other_post, traits: [:invalid_input]
  end
end
