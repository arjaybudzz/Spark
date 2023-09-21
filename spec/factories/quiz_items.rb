FactoryBot.define do
  factory :quiz_item do
    problem { "MyText" }
    answer { "MyString" }
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
