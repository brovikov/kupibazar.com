# -*- encoding : utf-8 -*-
class AddLogisticsToItems < ActiveRecord::Migration
  def change
    add_column :items, :havy, :boolean, :default => 0
    add_column :items, :order_no, :string
    add_column :items, :track, :string
  end
end
