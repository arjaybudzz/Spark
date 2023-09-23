class ApplicationController < ActionController::API
  include Authenticable
  include SubjectAuthentication
  include TopicAuthentication
  include QuizAuthentication
  include QuizItemAuthentication
  include UserAuthentication
  include AnswerSheetAuthentication
  include PostAuthentication
end
