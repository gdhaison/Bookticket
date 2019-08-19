module Supports
  class MovieTheater < ApplicationRecord
    attr_accessor :theater, :movie, :room, :city

    def theaters
      @theaters ||= Theater.pluck(:name, :id)
    end

    def movies
      @movies ||= Movie.pluck(:name, :id)
    end

    def rooms
      @rooms ||= Room.pluck(:name, :id)
    end

    def cities
      @cities ||= City.all
    end

    def all_theaters
      @all_theaters ||= Theater.all
    end
  end
end
