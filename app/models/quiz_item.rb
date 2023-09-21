class QuizItem < ApplicationRecord
  belongs_to :quiz

  validates :problem, presence: true
  validates :answer, presence: true
  validates :point, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
