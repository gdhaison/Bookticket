class AddOrderStatusToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_status, :boolean, default: false
  end
end
