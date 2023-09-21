FactoryBot.define do
  factory :quiz do
    difficulty { Faker::Educator.subject }
    score { 1 }
    topic { association :topic }

    trait :invalid do
      difficulty { nil }
    end

    factory :quiz_sample do
      difficulty { 'Easy' }
      score { 50 }
      topic { association :topic }
    end

    trait :another_sample do
      difficulty { 'Medium' }
    end

    factory :empty_difficulty, traits: [:invalid]
    factory :medium_quiz, traits: [:another_sample]
  end
end
