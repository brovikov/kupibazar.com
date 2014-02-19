# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  data       :date             not null
#  time       :time             not null
#  value      :decimal(6, 2)    not null
#  user_id    :integer          not null
#  comment    :string(255)
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Payment < ActiveRecord::Base
  attr_accessible :data, :time, :user_id, :value, :comment, :status
  validates :data, presence: true
  validates :time, presence: true
  validates :value, presence: true
  validates_numericality_of :value, greater_than: 0, message: 'Сумма - только цифры, разделитель - точка, например: 288.80' 
  validates :comment, :length => { :maximum => 200 }
  validates_date :data
  validates_time :time
  belongs_to :user
end
