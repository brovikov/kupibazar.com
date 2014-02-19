# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: config_apps
#
#  id         :integer          not null, primary key
#  city       :string(255) id: 1- Tiraspolx, 2 - Odessa
#  currency   :string(255)
#  rate       :decimal(6, 2)    not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class ConfigApp < ActiveRecord::Base
  attr_accessible :city, :currency, :rate
  has_many :user
end
