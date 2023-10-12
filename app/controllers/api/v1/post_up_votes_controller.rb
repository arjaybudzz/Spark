class Api::V1::PostUpVotesController < ApplicationController
  before_action :check_existing_post, only: %i[create]
  before_action :setup_upvote, only: %i[destroy]

  after_action :update_post_upvote, only: %i[create destroy]

  def create
    @upvote = current_post.post_up_votes.build
    render json: PostUpVoteSerializer.new(@upvote).serializable_hash, status: :created if @upvote.save
  end

  def destroy
    @upvote.destroy
    head 204
  end

  private

  def setup_upvote
    @upvote = PostUpVote.find(params[:id])
  end

  def update_post_upvote
    ComputeReaction.compute_upvote(current_post, PostUpVote.count)
  end
end
