class Api::V1::PostsController < ApplicationController
  before_action :setup_post, only: %i[show update destroy]
  before_action :check_user_login, only: %i[create]
  before_action :check_user_owner, only: %i[update destroy]

  def index
    @post = Post.all
    render json: @post
  end

  def show
    render json: @post
  end

  def create
    @post = current_user.posts.build(permitted_post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(permitted_post_params)
      render json: @post, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    head 204
  end

  private

  def setup_post
    @post = Post.find(params[:id])
  end

  def permitted_post_params
    params.require(:post).permit(:body, :upvote, :downvote)
  end

  def check_user_owner
    head :forbidden unless @post.user_id == current_user&.id
  end
end
