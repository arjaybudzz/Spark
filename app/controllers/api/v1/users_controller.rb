class Api::V1::UsersController < ApplicationController
  before_action :setup_user, only: %i[show update destroy]
  before_action :check_login, only: %i[create]
  before_action :check_owner, only: %i[update destroy]

  def index
    @user = User.all
    render json: @user
  end

  def show
    render json: @user
  end

  def create
    @user = current_admin.users.build(permitted_user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(permitted_user_params)
      render json: @user, status: :ok
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

  def check_owner
    head :forbidden unless @user.admin_id == current_admin&.id
  end
end
