class City < ApplicationRecord
  require "csv"
  has_many :theaters, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
