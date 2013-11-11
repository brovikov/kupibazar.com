# -*- encoding : utf-8 -*-
class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :data, null: false
      t.time :time, null: false
      t.decimal :value, precision: 6, scale: 2, null: false
      t.integer :user_id, null: false
      t.string :comment
      t.integer :status, :default => 0, null: false
      t.timestamps
    end
    add_index :payments, [:user_id, :created_at]
  end
end
