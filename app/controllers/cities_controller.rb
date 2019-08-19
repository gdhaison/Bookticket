class CitiesController < ApplicationController
  def index
    @cities = City.order(name: :asc)
  end

  def show
    @city = City.find params[:id]
    @theaters = @city.theaters
  end
end
