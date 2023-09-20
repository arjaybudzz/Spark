class Api::V1::AdminsController < ApplicationController
  before_action :setup_admin, only: %i[show update destroy]

  def index
    @admin = Admin.all
    render json: @admin
  end

  def show
    render json: @admin
  end

  def create
    @admin = Admin.new(permitted_admin_params)

    if @admin.save
      render json: @admin, status: :created
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  def update
    if @admin.update(permitted_admin_params)
      render json: @admin, status: :ok
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @admin.destroy
    head 204
  end

  private

  def setup_admin
    @admin = Admin.find(params[:id])
  end

  def permitted_admin_params
    params.require(:admin).permit(:first_name, :middle_name, :last_name, :email, :password, :password_confirmation)
  end
end
