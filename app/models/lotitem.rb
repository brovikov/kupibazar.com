# == Schema Information
#
# Table name: lotitems
#
#  id          :integer          not null, primary key
#  value_total :decimal(6, 2)    default(0.0), not null
#  item        :string(255)
#  user_id     :integer          default(0)
#  lot_id      :integer
#  status      :integer          default(0), not null
#  color       :string(255)
#  comment     :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Lotitem < ActiveRecord::Base
  attr_accessible :item, :value_total, :status, :color, :comment, :user_id 
  belongs_to :user
  belongs_to :lot
end
