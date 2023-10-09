FactoryBot.define do
  factory :quiz_item do
    problem { "MyText" }
    answer { "A" }
    first_choice { "A" }
    second_choice { "B" }
    third_choice { "C" }
    fourth_choice { "D" }
    point { 1 }
    quiz { association :quiz }

    trait :invalid do
      problem { nil }
    end

    trait :wrong do
      problem { 'x + y = 6' }
    end

    factory :quiz_item_with_correct_answer do

      after(:create) do |quiz_item|
        create(:quiz_answer, answer: 'A')
        quiz_item.reload
      end
    end

    factory :quiz_item_with_wrong_answer do
      after(:create) do |quiz_item|
        create(:quiz_answer, answer: 'B')
        quiz_item.reload
      end
    end

    factory :empty_quiz_problem, traits: [:invalid]
    factory :wrong_problem, traits: [:wrong]
  end
end
