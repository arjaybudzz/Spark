class Api::V1::TokensController < ApplicationController
  def create
    @admin = Admin.find_by_email(permitted_admin_login_params[:email])

    if @admin&.authenticate(permitted_admin_login_params[:password])
      render json: {
        token: JsonWebToken.encode(admin_id: @admin.id),
        email: @admin.email
      }
    else
      head :unauthorized
    end
  end

  private

  def permitted_admin_login_params
    params.require(:admin).permit(:email, :password)
  end
end
