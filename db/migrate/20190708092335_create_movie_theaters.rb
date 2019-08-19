class CreateMovieTheaters < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_theaters do |t|
      t.references :theater, foreign_key: true
      t.references :movie, foreign_key: true
      t.datetime :time

      t.timestamps
    end
  end
end
