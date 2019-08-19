module Manager
  class TheatersController < Manager::BaseController
    skip_before_action :verify_authenticity_token
    before_action :theater, only: %i[edit update destroy]

    def index
      @theaters = Theater.order(created_at: :desc)
    end

    def new
      @theater = Theater.new
    end

    def create
      @theater = Theater.new theater_params
      if @theater.save
        @theaters = Theater.order(created_at: :desc)
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
      if @theater.update(theater_params)
        @theaters = Theater.order(created_at: :desc)
        respond_to do |format|
          format.html
          format.js
        end
      else
        render "form"
      end
    end

    def destroy
      if @theater.destroy
        respond_to do |format|
          format.html
          format.js
        end
      else
        flash[:error] = "Delete theater failed!"
      end
    end

    private

    def theater
      @theater = Theater.find params[:id]
    end

    def theater_params
      params.require(:theater).permit(:name, :city_id)
    end
  end
end
