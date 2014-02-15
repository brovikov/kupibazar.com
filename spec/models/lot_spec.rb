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
#  lotitem_id  :integer
#  catalog_id  :integer
#  annotation  :string(255)
#  status      :integer          default(0), not null
#  orderno     :string(255)
#  track       :string(255)
#  havy        :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Lot do
  pending "add some examples to (or delete) #{__FILE__}"
end
