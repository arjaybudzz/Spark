class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :middle_name, :last_name, :email, :credibility

  belongs_to :admin
end
