class Notification < ApplicationRecord
  belongs_to :order, optional: true, dependent: :destroy

  scope :unread, -> { where read: false }

  after_create_commit do
    NotificationBroadcastJob.perform_now(Notification.unread.size, self)
  end

  validates :event, presence: true
end
