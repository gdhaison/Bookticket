class BillingsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def index; end

  def new_card
    respond_to do |format|
      format.js
    end
  end

  def create_card
    respond_to do |format|
      if current_user.stripe_id.nil?
        customer = Stripe::Customer.create("email": current_user.email)
        current_user.update(stripe_id: customer.id)
      end

      card_token = params[:stripeToken]
      format.html { redirect_to billings_path, error: "Oops" } if card_token.nil?
      customer = Stripe::Customer.new current_user.stripe_id
      customer.source = card_token
      customer.save
      format.html { redirect_to success_path }
    end
  end

  def success
    @order = current_user.orders.last
    @order_items = @order.order_items
  end

  def payment
    customer = Stripe::Customer.new current_user.stripe_id
    order = current_user.orders.last
    @payment = Stripe::Charge.create customer: customer.id,
                                     amount: order.total / 10,
                                     description: "Payments",
                                     currency: "usd"
    @payment.save
    order.order_status = true
    order.chart = order.generate_qr
    order.save
    OrderMailer.order_mail(order, current_user).deliver_now if current_user.present?
    #order.order_email_send
    #OrderWorker.perform_async(current_user.id, order.id)
    qr_code_img = RQRCode::QRCode.new(order.id.to_s, level: :h).to_img.resize(200, 200)
    order.update_attribute :image, qr_code_img.to_string
    paid_seats = order.order_items.first.movie_theater.showtime_seats
                      .where(seat_id: order.order_items.pluck(:seat_id))
    paid_seats.each do |seat|
      seat.seat_available = false
      seat.save
    end
    flash[:success] = t ".success"
    redirect_to root_url
  end
end
