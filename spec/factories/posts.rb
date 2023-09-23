FactoryBot.define do
  factory :post do
    body { "MyText" }
    upvote { 1 }
    downvote { 1 }
    user { nil }
  end
end
