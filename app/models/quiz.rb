class Quiz < ApplicationRecord
  belongs_to :topic
  has_many :quiz_items, dependent: :destroy

  validates :difficulty, presence: true
  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
