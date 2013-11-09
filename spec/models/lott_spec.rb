# == Schema Information
#
# Table name: lotts
#
#  id         :integer          not null, primary key
#  value      :decimal(6, 2)    not null
#  name       :string(255)      not null
#  lot_number :string(255)      not null
#  color      :string(255)
#  size       :string(255)
#  lot_id     :integer          default(0), not null
#  user_id    :integer          default(0), not null
#  comment    :string(255)
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Lott do
  pending "add some examples to (or delete) #{__FILE__}"
end
