class QuizItem < ApplicationRecord
  after_create :create_quiz_answer_slot

  belongs_to :quiz
  has_one :quiz_answer, dependent: :destroy

  validates :problem, presence: true
  validates :answer, presence: true
  validates :point, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def create_quiz_answer_slot
    QuizAnswer.create!(answer_sheet_id: AnswerSheet.last.id, quiz_item_id: id, answer: 'unknown') if AnswerSheet.last
  end
end
