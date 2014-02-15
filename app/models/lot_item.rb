# == Schema Information
#
# Table name: lot_items
#
#  id          :integer          not null, primary key
#  value_total :decimal(6, 2)    not null
#  item        :string(255)
#  user_id     :integer          not null
#  lot_id      :integer          not null
#  status      :integer          default(0), not null
#  color       :string(255)
#  comment     :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class LotItem < ActiveRecord::Base
  # attr_accessible :title, :body
end
