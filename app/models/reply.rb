class Reply < ApplicationRecord
  include CommonPostDataValidation
  belongs_to :comment
end
