FactoryBot.define do
  factory :quiz do
    difficulty { Faker::Educator.subject }
    score { 1 }
    topic { association :topic }

    trait :invalid do
      difficulty { nil }
    end

    factory :empty_difficulty, traits: [:invalid]
  end
end
