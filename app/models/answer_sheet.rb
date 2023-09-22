class AnswerSheet < ApplicationRecord
  belongs_to :quiz
  belongs_to :user

  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
