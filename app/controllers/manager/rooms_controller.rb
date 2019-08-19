module Manager
  class RoomsController < Manager::BaseController
    skip_before_action :verify_authenticity_token
    before_action :find_room, only: %i[show edit update destroy]
    before_action :find_seats, only: %i[show edit]
    before_action :order, only: %i[update create]

    def index
      @rooms = Room.order(created_at: :desc).page(params[:page]).per Settings.per_page_rooms
    end

    def show; end

    def new
      @theater = Theater.new
      @supports = Supports::Theater.new
      @room = Room.new
    end

    def create
      @room = Room.new room_params
      if @room.save
        room_id = @room.id
        create_30_seats room_id
        respond_to do |format|
          format.html
          format.js
        end
      else
        @theater = Theater.new
        @supports = Supports::Theater.new
        render "form"
      end
    end

    def edit
      @supports = Supports::Theater.new @room.theater
    end

    def update
      if @room.update room_params
        respond_to do |format|
          format.html
          format.js
        end
      else
        flash[:danger] = t ".failed"
        render "edit"
      end
    end

    def destroy
      @room.destroy
      flash[:success] = t ".success"
      redirect_to manager_rooms_path
    end

    private

    def room_params
      params.require(:room).permit(:name, :theater_id)
    end

    def find_room
      @room = Room.find params[:id]
    end

    def create_30_seats room_id
      ("A".."E").each do |row|
        (1..6).each do |col|
          seat = Seat.new
          seat.name = "#{row}#{col}"
          seat.room_id = room_id
          seat.available = true
          seat.save
        end
      end
    end

    def find_seats
      @seats = @room.seats.pluck(:id, :name, :available)
    end

    def order
      @rooms = Room.order(created_at: :desc)
    end
  end
end
