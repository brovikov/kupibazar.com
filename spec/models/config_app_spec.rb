# == Schema Information
#
# Table name: config_apps
#
#  id         :integer          not null, primary key
#  city       :string(255)
#  currency   :string(255)
#  rate       :decimal(6, 2)    not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe ConfigApp do
  pending "add some examples to (or delete) #{__FILE__}"
end
