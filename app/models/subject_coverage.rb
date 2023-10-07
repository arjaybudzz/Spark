class SubjectCoverage < ApplicationRecord
  belongs_to :admin
  has_many :subjects, dependent: :destroy
  validates :name, presence: true
end
