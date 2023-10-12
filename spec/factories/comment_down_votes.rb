FactoryBot.define do
  factory :comment_down_vote do
    is_clicked { false }
    comment { association :comment }
  end
end
