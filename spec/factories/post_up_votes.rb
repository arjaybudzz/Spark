FactoryBot.define do
  factory :post_up_vote do
    is_clicked { false }
    post { nil }
  end
end
