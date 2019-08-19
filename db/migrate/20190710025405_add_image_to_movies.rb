class AddImageToMovies < ActiveRecord::Migration[5.2]
  def up
    add_attachment :movies, :image
  end

  def down
    remove_attachment :movies, :image
  end
end
