class Admin < ApplicationRecord
  include CommonUserDataValidation

  has_many :users, dependent: :destroy
  has_many :subjects, dependent: :destroy
end
