class Api::V1::CommentsController < ApplicationController
  before_action :setup_comment, only: %i[show update destroy]
  before_action :check_existing_post, only: %i[create]
  before_action :check_post, only: %i[update destroy]

  def index
    @comment = Comment.all
    render json: CommentSerializer.new(@comment).serializable_hash
  end

  def show
    options = { include: [:post] }
    render json: CommentSerializer.new(@comment, options).serializable_hash
  end

  def create
    @comment = current_post.comments.build(permitted_comment_params)

    if @comment.save
      render json: CommentSerializer.new(@comment).serializable_hash, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(permitted_comment_params)
      render json: CommentSerializer.new(@comment).serializable_hash, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    head 204
  end

  private

  def setup_comment
    @comment = Comment.find(params[:id])
  end

  def permitted_comment_params
    params.require(:comment).permit(:body, :upvote, :downvote)
  end

  def check_post
    head :forbidden unless @comment.post_id == current_post&.id
  end
end
