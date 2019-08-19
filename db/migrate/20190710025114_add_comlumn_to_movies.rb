class AddComlumnToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :director, :string
    add_column :movies, :actor, :string
    add_column :movies, :release, :datetime
    add_column :movies, :duration, :integer
    add_column :movies, :rated, :string
    add_column :movies, :trailer, :string
    add_column :movies, :description, :string
  end
end
