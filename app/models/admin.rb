class Admin < ApplicationRecord
  has_many :notifications, dependent: :destroy

  validates :name, presence: true, length: { minimum: 4, maximum: 10 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
