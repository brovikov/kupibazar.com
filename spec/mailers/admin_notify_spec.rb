require "spec_helper"

describe AdminNotify do
  describe "nasklade" do
    let(:mail) { AdminNotify.nasklade }

    it "renders the headers" do
      mail.subject.should eq("Nasklade")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
