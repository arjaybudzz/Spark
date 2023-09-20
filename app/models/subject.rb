class Subject < ApplicationRecord
  belongs_to :admin

  has_many :topics, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :admin_id }
end
