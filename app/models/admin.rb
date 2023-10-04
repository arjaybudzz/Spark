class Admin < ApplicationRecord
  include CommonUserDataValidation

  has_many :users, dependent: :destroy
  has_many :subjects, dependent: :destroy
  has_many :coverages, dependent: :destroy
end
