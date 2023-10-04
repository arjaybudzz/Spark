FactoryBot.define do
  factory :quiz_item do
    problem { "MyText" }
    answer { "MyString" }
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

    factory :empty_quiz_problem, traits: [:invalid]
    factory :wrong_problem, traits: [:wrong]
  end
end
