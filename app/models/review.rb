class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :rate, presence: true
end
