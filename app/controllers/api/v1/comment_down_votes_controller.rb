class Api::V1::CommentDownVotesController < ApplicationController
  before_action :check_existing_comment, only: %i[create]
  before_action :setup_downvote, only: %i[destroy]

  after_action :compute_downvote_reaction, only: %i[create destroy]

  def create
    @comment_downvote = current_comment.comment_down_votes.build

    render json: @comment_downvote, status: :created if @comment_downvote.save
  end

  def destroy
    @comment_downvote.destroy
    head 204
  end

  private

  def setup_downvote
    @comment_downvote = CommentDownVote.find(params[:id])
  end

  def compute_downvote_reaction
    ComputeReaction.compute_downvote(current_comment, CommentDownVote.count)
  end
end
