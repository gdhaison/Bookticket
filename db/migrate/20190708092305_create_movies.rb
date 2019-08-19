class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :name
      t.boolean :available
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
