FactoryBot.define do
  factory :answer_sheet do
    score { 100 }
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

    factory :empty_quiz, traits: %i[invalid]
  end
end
