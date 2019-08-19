class AddRoomIdToMovieTheaters < ActiveRecord::Migration[5.2]
  def change
    add_column :movie_theaters, :room_id, :integer
  end
end
