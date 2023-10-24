class Admin < ApplicationRecord
  include CommonUserDataValidation

  has_many :subject_coverages, dependent: :destroy
end
