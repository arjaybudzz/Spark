class Api::V1::PostTokensController < ApplicationController
  def create
    @post = Post.find_by_body(permitted_post_params[:body])

    if @post
      render json: {
        post_token: JsonWebToken.encode(post_id: @post.id),
        body: @post.body,
        upvote: @post.upvote,
        downvote: @post.downvote
      }
    else
      head :unauthorized
    end
  end

  private

  def permitted_post_params
    params.require(:post).permit(:body)
  end
end
