# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  value       :decimal(6, 2)    not null
#  link        :string(255)      not null
#  name        :string(255)      not null
#  seller_rate :string(255)      not null
#  img         :string(255)      not null
#  color       :string(255)
#  size        :string(255)
#  order_id    :integer          not null
#  comment     :string(255)
#  status      :integer          default(0), not null
#  count       :integer          default(1), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  havy        :boolean          default(FALSE)
#  order_no    :string(255)
#  track       :string(255)
#  value_total :decimal(6, 2)    default(0.0)
#

# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Item do
  pending "add some examples to (or delete) #{__FILE__}"
end
