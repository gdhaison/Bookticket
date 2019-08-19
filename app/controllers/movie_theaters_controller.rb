class MovieTheatersController < ApplicationController
  def show
    @movie_theater = MovieTheater.find params[:id]
  end
end
