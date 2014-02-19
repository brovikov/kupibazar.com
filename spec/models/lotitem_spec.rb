# == Schema Information
#
# Table name: lotitems
#
#  id          :integer          not null, primary key
#  value_total :decimal(6, 2)    default(0.0), not null
#  item        :string(255)
#  user_id     :integer          default(0)
#  lot_id      :integer
#  status      :integer          default(0), not null
#  color       :string(255)
#  comment     :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Lotitem do
  pending "add some examples to (or delete) #{__FILE__}"
end
