module Manager
  class CitiesController < Manager::BaseController
    skip_before_action :verify_authenticity_token
    before_action :find_city, except: %i[index new create]
    before_action :order, only: %i[create update]

    def index
      @cities = City.order(updated_at: :desc).page(params[:page]).per Settings.per_page_cities
    end

    def new
      @city = City.new
    end

    def create
      @city = City.new city_params
      @cities = City.order(updated_at: :desc).page(params[:page]).per Settings.per_page_cities
      if @city.save
        respond_to do |format|
          format.html
          format.js
        end
      else
        render "form"
      end
    end

    def edit; end

    def update
      if @city.update city_params
        respond_to do |format|
          format.html
          format.js
        end
      else
        render "edit"
      end
    end

    def destroy
      @city.destroy
      flash[:success] = t ".success"
      redirect_to manager_cities_path
    end

    private

    def city_params
      params.require(:city).permit(:name)
    end

    def find_city
      @city = City.find params[:id]
    end

    def order
      @cities = City.order(created_at: :desc)
    end
  end
end
