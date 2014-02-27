# == Schema Information
#
# Table name: catalogs
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  img         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Catalog < ActiveRecord::Base
  attr_accessible :description, :img, :title, :catalogitems_attributes
  has_many :catalogitems, :dependent => :destroy
  accepts_nested_attributes_for :catalogitems,  :allow_destroy => true
end
