FactoryBot.define do
  factory :reply do
    body { "MyText" }
    upvote { 1 }
    downvote { 1 }
    comment { association :comment }


    trait :invalid do
      body { nil }
    end

    trait :wrong do
      body { 'Some reply' }
    end

    factory :empty_reply, traits: [:invalid]
    factory :other_reply, traits: [:wrong]
  end
end
