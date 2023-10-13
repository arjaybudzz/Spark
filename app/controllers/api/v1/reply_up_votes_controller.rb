class Api::V1::ReplyUpVotesController < ApplicationController
  before_action :check_existing_reply, only: %i[create]
  before_action :setup_upvote, only: %i[destroy]

  after_action :compute_reply_upvote, only: %i[create destroy]

  def create
    @reply_upvote = current_reply.reply_up_votes.build

    render json: @reply_upvote, status: :created if @reply_upvote.save
  end

  def destroy
    @reply_upvote.destroy
    head 204
  end

  private

  def setup_upvote
    @reply_upvote = ReplyUpVote.find(params[:id])
  end

  def compute_reply_upvote
    ComputeReaction.compute_upvote(current_reply, ReplyUpVote.count)
  end
end
