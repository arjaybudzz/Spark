class Api::V1::PostUpVotesController < ApplicationController
  before_action :check_existing_post, only: %i[create]
  before_action :setup_upvote, only: %i[destroy]

  def create
    @upvote = current_post.post_up_votes.build
    if @upvote.save
      render json: PostUpVoteSerializer.new(@upvote).serializable_hash, status: :created
    else
      render json: @upvote.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @upvote.destroy
    head 204
  end

  private

  def setup_upvote
    @upvote = PostUpVote.find(params[:id])
  end
end
