class ComputeCredibility
  def self.compute(user)
    begin
      total_upvotes = 0
      total_downvotes = 0
      user.posts.each do |post|
        total_upvotes += post.upvote.to_f
        total_downvotes += post.downvote.to_f
      end

      credibility = (total_upvotes - total_downvotes) / (total_upvotes + total_downvotes)

      user.update(credibility: credibility)
    rescue ZeroDivisionError
      user.update(credibility: 0)
    end
  end
end
