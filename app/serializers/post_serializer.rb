class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :upvote, :downvote

  belongs_to :user
end
