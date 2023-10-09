class QuizItem < ApplicationRecord
  after_create :create_quiz_answer
  belongs_to :quiz
  has_one :quiz_answer, dependent: :destroy

  validates :problem, presence: true
  validates :answer, presence: true
  validates :point, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :first_choice, presence: true
  validates :second_choice, presence: true
  validates :third_choice, presence: true
  validates :fourth_choice, presence: true

  def create_quiz_answer
    QuizAnswer.create!(answer_sheet_id: quiz.answer_sheet.id, quiz_item_id: id, answer: 'unknown') if quiz.answer_sheet
  end
end
