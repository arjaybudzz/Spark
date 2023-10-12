class ComputeReaction
  def self.compute_upvote(post, react_number)
    post.update(upvote: react_number)
  end

  def self.compute_downvote(post, react_number)
    post.update(downvote: react_number)
  end
end
