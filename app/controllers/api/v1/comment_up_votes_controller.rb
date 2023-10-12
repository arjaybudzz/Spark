class Api::V1::CommentUpVotesController < ApplicationController
  before_action :check_existing_comment, only: %i[create]
  before_action :setup_comment_upvote, only: %i[destroy]

  after_action :compute_comment_upvote, only: %i[create destroy]

  def create
    @comment_upvote = current_comment.comment_up_votes.build

    render json: CommentUpVoteSerializer.new(@comment_upvote).serializable_hash, status: :created if @comment_upvote.save
  end

  def destroy
    @comment_upvote.destroy
    head 204
  end

  private

  def setup_comment_upvote
    @comment_upvote = CommentUpVote.find(params[:id])
  end

  def compute_comment_upvote
    ComputeReaction.compute_upvote(current_comment, CommentUpVote.count)
  end
end
