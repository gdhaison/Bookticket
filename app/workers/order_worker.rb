class OrderWorker
  include Sidekiq::Worker

  def perform user_id, order_id
    order = Order.find order_id
    current_user = User.find user_id
    OrderMailer.order_mail(order, current_user).deliver_now if current_user.present?
  end
end
