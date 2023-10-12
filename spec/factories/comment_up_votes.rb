FactoryBot.define do
  factory :comment_up_vote do
    is_clicked { true }
    comment { association :comment }
  end
end
