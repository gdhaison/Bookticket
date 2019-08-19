class Category < ApplicationRecord
  has_many :movies, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  class << self
    def import file
      CSV.foreach(file.path, headers: true) do |row|
        Category.create! row.to_hash
      end
    end

    def as_csv
      CSV.generate do |csv|
        csv << column_names
        all.find_each do |category|
          csv << category.attributes.values_at(*column_names)
        end
      end
    end
  end
end
