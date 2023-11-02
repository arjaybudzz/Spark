FactoryBot.define do
  factory :post do
    body { "MyText" }
    upvote { 1 }
    downvote { 0 }
    auth_token { "anything" }
    user { association :user }

    trait :invalid do
      body { nil }
    end

    trait :invalid_input do
      body { 'some text' }
    end

    factory :sample_post do
      body { 'some post' }
    end

    factory :upvote_and_downvote do
      upvote { 1 }
      downvote { 0 }
      auth_token { "anything" }
    end

    factory :downvote_post do
      body { "some post" }
      upvote { 0 }
      downvote { 1 }
      auth_token { "anything" }
    end

    factory :empty_post, traits: [:invalid]
    factory :other_post, traits: [:invalid_input]
  end
end
