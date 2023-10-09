class Reply < ApplicationRecord
  include CommonPostDataValidation
  belongs_to :comment

  validates :user_name, presence: true
end
