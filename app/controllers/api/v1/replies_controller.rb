class Api::V1::RepliesController < ApplicationController
  before_action :setup_reply, only: %i[show update destroy]
  before_action :check_existing_comment, only: %i[create]
  before_action :check_comment, only: %i[destroy]

  wrap_parameters include: %i[user_name body upvote downvote]

  def index
    @reply = Reply.all
    render json: ReplySerializer.new(@reply).serializable_hash
  end

  def show
    options = { include: %i[comment reply_up_votes reply_down_votes] }
    render json: ReplySerializer.new(@reply, options).serializable_hash
  end

  def create
    @reply = current_comment.replies.build(permitted_reply_params)

    if @reply.save
      render json: ReplySerializer.new(@reply).serializable_hash, status: :created
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  def update
    if @reply.update(permitted_reply_params)
      render json: ReplySerializer.new(@reply).serializable_hash, status: :ok
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @reply.destroy
    head 204
  end

  private

  def setup_reply
    @reply = Reply.find(params[:id])
  end

  def permitted_reply_params
    params.require(:reply).permit(:user_name, :body, :upvote, :downvote)
  end

  def check_comment
    head :forbidden unless @reply.comment_id == current_comment&.id
  end
end
