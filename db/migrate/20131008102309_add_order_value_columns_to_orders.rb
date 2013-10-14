class AddOrderValueColumnsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order_value, :decimal, precision: 6, scale: 2, :default => 0
  end
end
