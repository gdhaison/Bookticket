class Seat < ApplicationRecord
  belongs_to :room
  has_many :showtime_seats, dependent: :destroy

  validates :name, presence: true
end
