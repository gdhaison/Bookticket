class CreateSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :seats do |t|
      t.string :name
      t.references :room
      t.boolean :available

      t.timestamps
    end
  end
end
