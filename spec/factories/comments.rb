FactoryBot.define do
  factory :comment do
    body { "MyText" }
    upvote { 1 }
    downvote { 1 }
    post { association :post }

    trait :invalid do
      body { nil }
    end

    factory :empty_comment, traits: [:invalid]
  end
end
