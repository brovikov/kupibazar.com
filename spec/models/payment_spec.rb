# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  data       :date             not null
#  time       :time             not null
#  value      :decimal(6, 2)    not null
#  user_id    :integer          not null
#  comment    :string(255)
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Payment do

 # let(:user) { FactoryGirl.create(:user) }
  before do
    # Этот код кривой!
    @payment = Payment.new(value: "100", user_id: current_user)
  end

  subject { @micropost }

  it { should respond_to(:value) }
  it { should respond_to(:user_id) }
end
