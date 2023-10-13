FactoryBot.define do
  factory :reply_down_vote do
    is_clicked { false }
    reply { association :reply }
  end
end
