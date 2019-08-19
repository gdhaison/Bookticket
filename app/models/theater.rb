class Theater < ApplicationRecord
  belongs_to :city
  has_many :rooms, dependent: :destroy
  has_many :movie_theaters, dependent: :destroy

  validates :city_id, presence: true
  validates :name, presence: true, uniqueness: true
end
