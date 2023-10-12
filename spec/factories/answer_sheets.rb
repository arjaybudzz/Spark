FactoryBot.define do
  factory :answer_sheet do
    score { 0 }
    quiz { association :quiz }
    user { association :user }

    trait :invalid do
      quiz { nil }
    end

    factory :sample_answer_sheet do
      score { 50 }
      quiz_id { 10 }
      user_id { 1 }
    end

    factory :correct do
      user_id { 1 }
      quiz_id { 10 }
    end

    factory :wrong do
      quiz { association :quiz }
      user { association :user }
      score { 1 }
    end

    factory :answer_sheet_with_correct_answers do
      transient do
        quiz_answer_count { 10 }
      end
      after(:create) do |answer_sheet, evaluator|
        create_list(:quiz_answer, evaluator.quiz_answer_count, answer_sheet: answer_sheet)
        answer_sheet.reload
      end
    end

    factory :answer_sheet_with_wrong_answers do
      transient do
        quiz_answer_count { 10 }
      end

      after(:create) do |answer_sheet, evaluator|
        create_list(:wrong_answer, evaluator.quiz_answer_count, answer_sheet: answer_sheet)

        answer_sheet.reload
      end
    end

    factory :empty_quiz, traits: %i[invalid]
  end
end
