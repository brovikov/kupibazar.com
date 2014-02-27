# == Schema Information
#
# Table name: catalogitems
#
#  id          :integer          not null, primary key
#  line        :string(255)
#  description :string(255)
#  img         :string(255)
#  catalog_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Catalogitem < ActiveRecord::Base
  attr_accessible :catalog_id, :description, :img, :line
  belongs_to :catalog
end
