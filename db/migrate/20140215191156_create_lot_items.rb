class CreateLotItems < ActiveRecord::Migration
  def change
    create_table :lot_items do |t|
      t.decimal :value_total, precision: 6, scale: 2, null: false
      t.string :item
      t.integer :user_id, null: false
      t.integer :lot_id, null: false
      t.integer :status, :default => 0, null: false
      t.string :color
      t.string :comment
      t.timestamps
    end
  end
end
