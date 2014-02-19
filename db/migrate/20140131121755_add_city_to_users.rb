# -*- encoding : utf-8 -*-
class AddCityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :configApp_id, :integer
  end
end
