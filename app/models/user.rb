class User < ApplicationRecord
  include CommonUserDataValidation
  belongs_to :admin

  validates :credibility, presence: true
end
