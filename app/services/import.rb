class Import
  class << self
    def call file
      Category.import(file)
    rescue StandardError => e
      Rails.logger.error e.message
    end
  end
end
