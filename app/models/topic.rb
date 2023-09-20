class Topic < ApplicationRecord
  belongs_to :subject

  validates :name, presence: true, uniqueness: { scope: :subject_id }
  validates :discussion, presence: true
end
