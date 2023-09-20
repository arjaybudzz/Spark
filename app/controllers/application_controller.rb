class ApplicationController < ActionController::API
  include Authenticable
  include SubjectAuthentication
end
