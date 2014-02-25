# == Schema Information
#
# Table name: lots
#
#  id          :integer          not null, primary key
#  value       :decimal(6, 2)    not null
#  link        :string(255)      not null
#  name        :string(255)      not null
#  seller_rate :string(255)      default("0"), not null
#  img         :string(255)      not null
#  color       :string(255)
#  catalog_id  :integer
#  topic_id    :integer
#  moderator   :integer
#  processing  :integer
#  annotation  :text
#  status      :integer          default(0), not null
#  orderno     :string(255)
#  track       :string(255)
#  havy        :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# -*- encoding : utf-8 -*-
class Lot < ActiveRecord::Base
  attr_accessible :value, :link, :name, :seller_rate, :img, :color, :annotation, :status, 
  :orderno, :track, :havy, :lotitems_attributes, :processing, :moderator, :topic_id
  has_many :lotitems, :dependent => :destroy
  has_one :topic, :dependent => :destroy
  accepts_nested_attributes_for :lotitems,  :allow_destroy => true
  validates :link, presence: true
  validates :name, presence: true
  validates :seller_rate, presence: true
  validates :img, presence: true
  validates :value, presence: true
  validates_numericality_of :value, greater_than_or_equal_to: 0, message: 'Сумма - только цифры, разделитель - точка, например: 288.80' 
end
