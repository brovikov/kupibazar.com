require "spec_helper"

describe PaymentNotify do
  describe "received" do
    let(:mail) { PaymentNotify.received }

    it "renders the headers" do
      mail.subject.should eq("Received")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "problem" do
    let(:mail) { PaymentNotify.problem }

    it "renders the headers" do
      mail.subject.should eq("Problem")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
