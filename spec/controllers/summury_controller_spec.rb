require 'spec_helper'

describe SummuryController do

  describe "GET 'totals'" do
    it "returns http success" do
      get 'totals'
      response.should be_success
    end
  end

end
