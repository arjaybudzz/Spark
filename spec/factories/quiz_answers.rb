FactoryBot.define do
  factory :quiz_answer do
    answer { 'A' }
    quiz_item { association :quiz_item }
    answer_sheet { association :answer_sheet }

    trait :invalid do
      answer { nil }
    end

    factory :empty_answer, traits: [:invalid]
  end
end
