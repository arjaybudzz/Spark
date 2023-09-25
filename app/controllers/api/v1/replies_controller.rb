class Api::V1::RepliesController < ApplicationController
  before_action :setup_reply, only: %i[show]
  before_action :check_existing_comment, only: %i[create]

  def index
    @reply = Reply.all
    render json: @reply
  end

  def show
    render json: @reply
  end

  def create
    @reply = current_comment.replies.build(permitted_reply_params)

    if @reply.save
      render json: @reply, status: :created
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  private

  def setup_reply
    @reply = Reply.find(params[:id])
  end

  def permitted_reply_params
    params.require(:reply).permit(:body, :upvote, :downvote)
  end
end
