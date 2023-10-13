class Api::V1::ReplyDownVotesController < ApplicationController
  before_action :check_existing_reply, only: %i[create]
  before_action :setup_reply_downvote, only: %i[destroy]

  after_action :compute_reply_downvote, only: %i[create destroy]

  def create
    @reply_downvote = current_reply.reply_down_votes.build

    render json: ReplyDownVoteSerializer.new(@reply_downvote).serializable_hash, status: :created if @reply_downvote.save
  end

  def destroy
    @reply_downvote.destroy
    head 204
  end

  private

  def setup_reply_downvote
    @reply_downvote = ReplyDownVote.find(params[:id])
  end

  def compute_reply_downvote
    ComputeReaction.compute_downvote(current_reply, ReplyDownVote.count)
  end
end
