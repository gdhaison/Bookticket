class AddImageToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :image_uid, :string
    add_column :orders, :image_size, :integer
  end
end
