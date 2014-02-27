class CreateCatalogitems < ActiveRecord::Migration
  def change
    create_table :catalogitems do |t|
      t.string :line
      t.string :description
      t.string :img
      t.integer :catalog_id

      t.timestamps
    end
  end
end
