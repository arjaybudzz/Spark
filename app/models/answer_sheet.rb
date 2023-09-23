class AnswerSheet < ApplicationRecord
  belongs_to :quiz
  belongs_to :user, inverse_of: :answer_sheets
  has_many :quiz_answers

  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
