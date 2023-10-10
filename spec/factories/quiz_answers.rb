FactoryBot.define do
  factory :quiz_answer do
    answer { 'A' }
    quiz_item { association :quiz_item }
    answer_sheet { association :answer_sheet }

    trait :invalid do
      answer { nil }
    end

    trait :wrong do
      answer { 'B' }
    end


    factory :empty_answer, traits: [:invalid]
    factory :wrong_answer, traits: [:wrong]
  end
end
