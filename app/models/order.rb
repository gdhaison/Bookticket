class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_one :notification

  validates :total, numericality: { greater_than: 0 }

  before_save :update_total

  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: proc { |attr| attr[:seat_id].blank? }

  dragonfly_accessor :image

  after_create_commit { notify }

  def total
    total = order_items.length * 50_000
    total
  end

  def order_email_send
    order = Order.find self.id
    current_user = User.find self.user_id
    OrderMailer.order_mail(order, current_user).deliver_now if current_user.present?
  end

  def generate_qr
    require "google-qr"
    qr = GoogleQR.new(data: id.to_s, size: "200x200", margin: 4, error_correction: "L")
    qr.to_s
  end

  private

  def notify
    Notification.create(event: "New order")
  end

  def update_total
    self[:total] = total
  end
end
