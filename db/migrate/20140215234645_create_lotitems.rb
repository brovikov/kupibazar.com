class CreateLotitems < ActiveRecord::Migration
  def change
    create_table :lotitems do |t|
      t.decimal :value_total, precision: 6, scale: 2, null: false, default: 0
      t.string :item
      t.integer :user_id, default: 0
      t.integer :lot_id
      t.integer :status, :default => 0, null: false
      t.string :color
      t.string :comment
      t.timestamps   
    end
  end
end
