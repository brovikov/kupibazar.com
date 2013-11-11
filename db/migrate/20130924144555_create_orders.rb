# -*- encoding : utf-8 -*-
class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :status, :default => 0, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
    add_index :orders, [:user_id, :created_at, :id]
  end
end
