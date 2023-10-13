FactoryBot.define do
  factory :reply_up_vote do
    is_clicked { false }
    reply { association :reply }
  end
end
