class Api::V1::PostDownVotesController < ApplicationController
  before_action :setup_post_down_vote, only: %i[destroy]
  before_action :check_existing_post, only: %i[create]

  after_action :evaluate_downvote, only: %i[create destroy]

  def create
    @post_down_vote = current_post.post_down_votes.build

    render json: PostDownVoteSerializer.new(@post_down_vote).serializable_hash, status: :created if @post_down_vote.save
  end

  def destroy
    @post_down_vote.destroy
    head 204
  end

  private

  def setup_post_down_vote
    @post_down_vote = PostDownVote.find(params[:id])
  end

  def evaluate_downvote
    ComputeReaction.compute_downvote(current_post, PostDownVote.count)
  end
end
