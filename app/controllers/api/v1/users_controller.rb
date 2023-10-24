class Api::V1::UsersController < ApplicationController
  before_action :setup_user, only: %i[show update destroy]
  before_action :check_user_login, only: %i[update destroy]
  before_action :compute_credibility, only: %i[show]

  after_action :send_confirmation_email, only: %i[create]
  wrap_parameters include: %i[first_name middle_name last_name email password password_confirmation]

  def index
    @user = User.search(params)
    render json: UserSerializer.new(@user).serializable_hash
  end

  def show
    options = { include: %i[answer_sheets posts comments] }
    render json: UserSerializer.new(@user, options).serializable_hash
  end

  def create
    @user = User.new(permitted_user_params)

    if @user.save
      render json: UserSerializer.new(@user).serializable_hash, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(permitted_user_params)
      render json: UserSerializer.new(@user).serializable_hash, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head 204
  end

  private

  def setup_user
    @user = User.find(params[:id])
  end

  def permitted_user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :email, :credibility, :password, :password_confirmation)
  end

  def send_confirmation_email
    UserMailer.received_confirmation(@user).deliver_now unless @user.email.nil?
  end

  def compute_credibility
    ComputeCredibility.compute(@user)
  end
end
