class ApplicationController < ActionController::API
  include Authenticable
  include SubjectAuthentication
  include TopicAuthentication
  include QuizAuthentication
end
