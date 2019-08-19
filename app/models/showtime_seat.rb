class ShowtimeSeat < ApplicationRecord
  belongs_to :movie_theater
  belongs_to :seat
end
