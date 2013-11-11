# -*- encoding : utf-8 -*-
class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.decimal :value, precision: 6, scale: 2, null: false
      t.string :link, null: false
      t.string :name, null: false
      t.string :seller_rate, null: false
      t.string :img, null: false
      t.string :color
      t.string :size
      t.integer :order_id, null: false
      t.string :comment
      t.integer :status, :default => 0, null: false
      t.integer :count, :default => 1, null: false
      t.timestamps
    end
    add_index :items, [:order_id, :created_at, :id]
  end
end
