class Quiz < ApplicationRecord
  after_create :create_answer_sheet

  belongs_to :topic
  has_many :quiz_items, dependent: :destroy
  has_one :answer_sheet, dependent: :destroy
  has_many :users, through: :answer_sheet

  validates :difficulty, presence: true
  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def create_answer_sheet
    AnswerSheet.create!(user_id: User.last.id, quiz_id: id, score: 0) if User.last
  end
end
