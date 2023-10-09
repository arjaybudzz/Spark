class ReplySerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :upvote, :downvote, :user_name

  belongs_to :comment
end
