class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.received_confirmation.subject
  #
  def received_confirmation(user)
    @user = user
    @greeting = 'Thank you for joining Spark! I hope it will help you achieve your dreams!'

    mail to: @user.email, from: ENV['GMAIL_USERNAME'], subject: 'Thank you for signing up!'
  end
end
