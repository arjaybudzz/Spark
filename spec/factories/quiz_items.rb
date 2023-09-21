FactoryBot.define do
  factory :quiz_item do
    problem { "MyText" }
    answer { "MyString" }
    point { 1 }
    quiz { association :quiz }

    trait :invalid do
      problem { nil }
    end

    factory :empty_quiz_problem, traits: [:invalid]
  end
end
