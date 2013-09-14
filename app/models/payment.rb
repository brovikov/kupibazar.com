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
  attr_accessible :data, :time, :user_id, :value, :comment, :status
  validates :data, presence: true #, message: 'Дата не может быть незаполненной' 
  validates :time, presence: true #, message: 'Время не может быть незаполненным' 
  validates :value, presence: true #,  :message 'Сумма не может быть незаполненной' 
  validates_numericality_of :value, message: 'Сумма - столько цифры, разделитель - запятая, например: 288,80' 
  validates :comment, :length => { :maximum => 200 }
  belongs_to :user
end
