class Reply < ApplicationRecord
  include CommonPostDataValidation
  belongs_to :comment
  has_many :reply_up_votes, dependent: :destroy
  has_many :reply_down_votes, dependent: :destroy

  validates :user_name, presence: true
end
