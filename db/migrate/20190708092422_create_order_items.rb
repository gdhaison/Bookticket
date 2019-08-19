class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :movie_theater, foreign_key: true
      t.references :order, foreign_key: true
      t.references :seat, foreign_key: true

      t.timestamps
    end
  end
end
