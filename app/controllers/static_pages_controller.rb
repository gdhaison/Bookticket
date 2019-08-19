class StaticPagesController < ApplicationController
  def home
    @movies = Movie.last Settings.amount_movie_index
  end

  def schedule
    @theater = Theater.find params[:theater]
    date = params[:date]
    @movie_theaters = @theater.movie_theaters.date_like date
    @movies = @movie_theaters.pluck(:movie_id).uniq.map { |id| Movie.find(id) }
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def date
    @movie = Movie.find params[:movie]
    @dates = @movie.movie_theaters.pluck(:time).map(&:to_date).uniq
  end

  def show_city
    movie_theaters = Movie.find(params[:movie]).movie_theaters.date_like(params[:date])
    theater_ids = movie_theaters.pluck(:theater_id).uniq
    city_ids = Theater.where(id: theater_ids).pluck(:city_id)
    @cities = City.where(id: city_ids)
  end

  def show_theater
    theater_ids = MovieTheater.movie_like(params[:movie].to_i).pluck(:theater_id).uniq
    theaters = Theater.where(id: theater_ids)
    @theaters = []
    theaters.each do |theater|
      @theaters << theater if theater.city_id == params[:city].to_i
    end
  end

  def show_showtime
    @movie_theaters = Theater.find(params[:theater]).movie_theaters
                             .where(movie_id: params[:movie].to_i).date_like(params[:date]).order(time: :asc)
  end
end
