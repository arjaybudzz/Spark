class ComputeReaction
  def self.compute_upvote(post)
    post.update(upvote: PostUpVote.count)
  end

  def self.compute_downvote(post)
    post.update(downvote: PostDownVote.count)
  end
end
