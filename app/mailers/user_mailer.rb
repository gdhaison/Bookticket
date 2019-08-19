class UserMailer < ApplicationMailer
  def welcome_send user
    @user = user
    mail to: user.email, subject: t(".welcome"), from: "ruby.dev.cinema@gmail.com"
  end

  def mail_month film
    @film = film
    User.all.each do |user|
      @user = user
      mail to: @user.email, subject: t(".title")
    end
  end
end
