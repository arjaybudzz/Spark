class Comment < ApplicationRecord
  include CommonPostDataValidation
  belongs_to :post
end
