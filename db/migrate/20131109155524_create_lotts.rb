# -*- encoding : utf-8 -*-
class CreateLotts < ActiveRecord::Migration
  def change
    create_table :lotts do |t|
      t.decimal :value, precision: 6, scale: 2, null: false
      t.string :name, null: false
      t.string :lot_number, null: false
      t.string :color
      t.string :size
      t.integer :lot_id, null: false, default: 0
      t.integer :user_id, null: false, default: 0
      t.string :comment
      t.integer :status, :default => 0, null: false
      t.timestamps
    end
  end
end
