FactoryBot.define do
  factory :quiz do
    difficulty { Faker::Educator.subject }
    score { 1 }
    topic { association :topic }

    trait :invalid do
      difficulty { nil }
    end

    trait :another_sample do
      difficulty { 'Medium' }
    end

    factory :quiz_with_quiz_items do
      transient do
        quiz_item_count { 10 }
      end

      after(:create) do |quiz, evaluator|
        create_list(:quiz_item, evaluator.quiz_item_count, quiz: quiz)
        quiz.reload
      end
    end

    factory :quiz_sample do
      difficulty { 'Easy' }
      score { 50 }
      topic { association :topic }
    end

    factory :empty_difficulty, traits: [:invalid]
    factory :medium_quiz, traits: [:another_sample]
  end
end
