# == Schema Information
#
# Table name: lotts
#
#  id         :integer          not null, primary key
#  value      :decimal(6, 2)    not null
#  name       :string(255)      not null
#  lot_number :string(255)      not null
#  color      :string(255)
#  size       :string(255)
#  lot_id     :integer          default(0), not null
#  user_id    :integer          default(0), not null
#  comment    :string(255)
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lott < ActiveRecord::Base
  attr_accessible :title, :body, :value, :color, :size,  :lot_id, :created_at, :updated_at,
  :comment, :status, :name, :lot_number
  validates :name, presence: true
  validates :lot_number, presence: true
  validates :value, presence: true
  validates_numericality_of :value, greater_than_or_equal_to: 0, message: 'Сумма - только цифры, разделитель - точка, например: 288.80' 
  validates :comment, :length => { :maximum => 255 }
  belongs_to :user
end
