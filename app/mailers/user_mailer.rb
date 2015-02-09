class UserMailer < ActionMailer::Base
  default from: "no-reply@jarvis.elasticbeanstalk.com"

def welcome_email(user)

  @user = user
  @url = 'http://jarvis.elasticbeanstalk.com'
  mail(to: @user.email, subject: 'Sign Up Confirmation'

end

end
