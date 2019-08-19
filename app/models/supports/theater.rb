module Supports
  class Theater < ApplicationRecord
    attr_reader :theater, :city

    def initialize theater
      @theater = theater
    end

    def names
      @names ||= Theater.pluck(:name, :id)
    end

    def cities
      @cities ||= City.all
    end
  end
end
