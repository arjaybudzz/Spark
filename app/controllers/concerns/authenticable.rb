module Authenticable
  def current_admin
    return @current_admin if @current_admin

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_admin = Admin.find(decoded[:admin_id]) rescue ActiveRecord::RecordNotFound
  end

  protected

  def check_login
    head :forbidden unless current_admin
  end
end
