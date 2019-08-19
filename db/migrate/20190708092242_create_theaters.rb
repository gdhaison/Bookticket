class CreateTheaters < ActiveRecord::Migration[5.2]
  def change
    create_table :theaters do |t|
      t.string :name
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
