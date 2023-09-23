module CommonPostDataValidation
  extend ActiveSupport::Concern

  included do
    validates :body, presence: true
    validates :upvote, numericality: { greater_than_or_equal_to: 0 }
    validates :downvote, numericality: { greater_than_or_equal_to: 0 }
  end
end
