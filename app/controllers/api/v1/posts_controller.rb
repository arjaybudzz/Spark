class Api::V1::PostsController < ApplicationController
  before_action :setup_post, only: %i[show update destroy]
  before_action :check_user_login, only: %i[create]
  before_action :check_user_owner, only: %i[destroy]

  def index
    @post = Post.all
    render json: PostSerializer.new(@post).serializable_hash
  end

  def show
    options = { include: %i[user comments] }
    render json: PostSerializer.new(@post, options).serializable_hash
  end

  def create
    @post = current_user.posts.build(permitted_post_params)

    if @post.save
      render json: PostSerializer.new(@post).serializable_hash, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(permitted_post_params)
      render json: PostSerializer.new(@post).serializable_hash, status: :ok
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
