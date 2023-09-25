class Api::V1::CommentTokensController < ApplicationController
  def create
    @reply = Reply.find_by_body(permitted_reply_params[:body])

    if @reply
      render json: {
        reply_token: JsonWebToken.encode(reply_id: @reply.id),
        id: @reply.id,
        body: @reply.body,
        upvote: @reply.upvote,
        downvote: @reply.downvote
      }
    else
      head :unauthorized
    end
  end

  private

  def permitted_reply_params
    params.require(:reply).permit(:body)
  end
end
