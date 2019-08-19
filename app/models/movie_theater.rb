class MovieTheater < ApplicationRecord
  belongs_to :theater
  belongs_to :movie
  belongs_to :room
  has_many :order_items
  has_many :showtime_seats, dependent: :destroy
  validates :time, presence: true
  validates :theater_id, presence: true
  validate :check_room, on: %i[create update edit]
  scope :date_like, ->(date) { where "time LIKE ?", "%#{date}%" }
  scope :movie_like, ->(movie_id) { where "movie_id = ?", movie_id.to_s }
  private

  def check_room
    room = Room.find room_id
    theater_room = room.theater
    theater = Theater.find theater_id
    errors.add(:base, "Room not belong to theater") unless theater == theater_room
  end
end
