class Api::V1::CommentTokensController < ApplicationController
  def create
    @comment = Comment.find_by_body(permitted_comment_params[:body])

    if @comment
      render json: {
        comment_token: JsonWebToken.encode(comment_id: @comment.id),
        id: @comment.id,
        body: @comment.body,
        upvote: @comment.upvote,
        downvote: @comment.downvote
      }
    else
      head :unauthorized
    end
  end

  private

  def permitted_comment_params
    params.require(:comment).permit(:body)
  end
end
