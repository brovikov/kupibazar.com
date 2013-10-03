# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  status     :integer          default(0), not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ActiveRecord::Base
  attr_accessible :status, :id, :user_id, :items_attributes
  has_many :items, :dependent => :destroy
  belongs_to :user
  accepts_nested_attributes_for :items, :reject_if => lambda { |a| a[:value].blank? }, :allow_destroy => true

end
