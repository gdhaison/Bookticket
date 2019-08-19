class AddChartToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :chart, :string
  end
end
