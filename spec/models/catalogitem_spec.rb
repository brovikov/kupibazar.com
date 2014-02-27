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

require 'spec_helper'

describe Catalogitem do
  pending "add some examples to (or delete) #{__FILE__}"
end
