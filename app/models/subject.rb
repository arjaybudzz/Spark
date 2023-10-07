class Subject < ApplicationRecord
  belongs_to :subject_coverage

  has_many :topics, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :subject_coverage_id }
end
