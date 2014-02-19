class CreateLots < ActiveRecord::Migration
  def change
    create_table :lots do |t|
      t.decimal :value, precision: 6, scale: 2, null: false
      t.string :link, null: false
      t.string :name, null: false
      t.string :seller_rate, default: 0, null: false
      t.string :img, null: false
      t.string :color
      t.integer :catalog_id
      t.integer :moderator
      t.integer :processing
      t.text :annotation
      t.integer :status, default: 0, null: false
      t.string :orderno
      t.string :track
      t.boolean :havy, default: 0
      t.timestamps
    end
    add_index :lots, [:created_at, :id, :orderno, :name]
  end
end

