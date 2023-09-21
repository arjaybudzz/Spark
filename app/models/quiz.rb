class Quiz < ApplicationRecord
  belongs_to :topic

  validates :difficulty, presence: true
  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
