# -*- encoding : utf-8 -*-
class CreateConfigApps < ActiveRecord::Migration
  def change
    create_table :config_apps do |t|
      t.string :city 
      t.string :currency 
      t.decimal :rate, precision: 6, scale: 2, null: false 
      t.timestamps
    end
  end
end
