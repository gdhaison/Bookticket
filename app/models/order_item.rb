class OrderItem < ApplicationRecord
  belongs_to :movie_theater
  belongs_to :order
  belongs_to :seat
end
