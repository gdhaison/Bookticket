class CreateShowtimeSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :showtime_seats do |t|
      t.references :movie_theater, foreign_key: true
      t.references :seat, foreign_key: true
      t.boolean :seat_available

      t.timestamps
    end
  end
end
