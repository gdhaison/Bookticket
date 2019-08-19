class ChangeTotalDatatypeToBigDecimalToOrder < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :total, :decimal, precision: 8, scale: 2
  end
end
