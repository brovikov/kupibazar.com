# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  data       :date
#  time       :time
#  value      :decimal(6, 2)
#  user       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Payment < ActiveRecord::Base
  attr_accessible :data, :time, :user_id, :value, :comment
  validates :comment, :length => { :maximum => 200 }
  belongs_to :user
end
