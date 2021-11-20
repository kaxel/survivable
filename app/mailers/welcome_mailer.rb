class WelcomeMailer < ApplicationMailer
    # sends a welcome email
    def welcome_email
      @user = params[:user]
      @url = 'https://survivable.app/sign_in'
      mail(to: @user.email, subject: 'Welcome to Survivable. Can you go the distance?')
    end
end