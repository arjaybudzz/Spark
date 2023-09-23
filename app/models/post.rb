class Post < ApplicationRecord
  include CommonPostDataValidation
  belongs_to :user
  has_many :comments, dependent: :destroy
end
