class Api::V1::AdminsController < ApplicationController
  before_action :setup_admin, only: %i[show update destroy]
  before_action :check_login, only: %i[update destroy]
  wrap_parameters include: %i[first_name middle_name last_name email password password_confirmation]

  def index
    @admin = Admin.all
    render json: AdminSerializer.new(@admin).serializable_hash
  end

  def show
    options = { include: %i[subject_coverages users] }
    render json: AdminSerializer.new(@admin, options).serializable_hash
  end

  def create
    @admin = Admin.new(permitted_admin_params)

    if @admin.save
      render json: AdminSerializer.new(@admin).serializable_hash, status: :created
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  def update
    if @admin.update(permitted_admin_params)
      render json: AdminSerializer.new(@admin).serializable_hash, status: :ok
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
