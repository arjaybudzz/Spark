FactoryBot.define do
  factory :comment do
    body { "MyText" }
    upvote { 1 }
    downvote { 1 }
    post { association :post }
    user_name { "name" }

    trait :invalid do
      body { nil }
    end

    trait :wrong do
      body { 'Some reply' }
    end

    factory :empty_comment, traits: [:invalid]
    factory :other_comment, traits: [:wrong]
  end
end
