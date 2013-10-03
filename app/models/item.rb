# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  value       :decimal(6, 2)    not null
#  link        :string(255)      not null
#  name        :string(255)      not null
#  seller_rate :string(255)      not null
#  img         :string(255)      not null
#  color       :string(255)
#  size        :string(255)
#  order_id    :integer          not null
#  comment     :string(255)
#  status      :integer          default(0), not null
#  count       :integer          default(1), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Item < ActiveRecord::Base
  attr_accessible :title, :body, :value, :link, :seller_rate, :img, :color, :size,  :order_id, :id, :created_at, :updated_at,
  :comment, :status, :count, :name
  belongs_to :order
 end
