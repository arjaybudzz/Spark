class ReplySerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :upvote, :downvote, :user_name

  belongs_to :comment
  has_many :reply_up_votes, dependent: :destroy
  has_many :reply_down_votes, dependent: :destroy
end
