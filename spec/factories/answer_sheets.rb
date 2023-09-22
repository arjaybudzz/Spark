FactoryBot.define do
  factory :answer_sheet do
    score { 1 }
    quiz { association :quiz }
    user { association :user }
  end
end
