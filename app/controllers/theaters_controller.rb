class TheatersController < ApplicationController
  def show
    @theater = Theater.find params[:id]
    @dates = @theater.movie_theaters.pluck(:time).map(&:to_date).uniq
  end
end
