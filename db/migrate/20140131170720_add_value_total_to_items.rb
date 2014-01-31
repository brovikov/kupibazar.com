class AddValueTotalToItems < ActiveRecord::Migration
  def change
    add_column :items, :value_total, :decimal, precision: 6, scale: 2, default: 0
  end
end
