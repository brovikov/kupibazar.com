class AddNikToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nik, :string 
    add_column :users, :balance, :decimal, null: false, :default => 0, precision: 6, scale: 2
  end
end
