class PostUpVote < ApplicationRecord
  belongs_to :post
  validates :is_clicked, presence: true
end
