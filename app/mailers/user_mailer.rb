class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email(user)
    @user = user
    email_with_name = %("#{@user.name} <#{@user.email}>")
    @url = 'http://example.com/login'
    mail(to: @user.email,
         subject: 'Welcome to my Awesome site')
  end
end
