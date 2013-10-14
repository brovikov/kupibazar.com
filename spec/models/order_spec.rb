# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  status      :integer          default(0), not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  order_value :integer          default(0)
#

require 'spec_helper'

describe Order do
  pending "add some examples to (or delete) #{__FILE__}"
end
