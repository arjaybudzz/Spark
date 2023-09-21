FactoryBot.define do
  factory :quiz_item do
    problem { "MyText" }
    answer { "MyString" }
    point { 1 }
    quiz { association :quiz }
  end
end
