class OrderMailer < ApplicationMailer
  def order_mail order, user
    @order = order
    @user = user
    mail to: @user.email, subject: t(".ordered"), from: "ruby.dev.cinema@gmail.com"
  end
end
