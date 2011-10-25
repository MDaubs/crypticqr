require 'spec_helper'

describe SecureQr do
  shared_examples_for "a secured QR model" do |secured, value|
    it "has an image url" do
      subject.image_url.should == "http://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=#{secured}"
    end

    it "has a secured value" do
      subject.secured.should == secured
    end

    it "has a value" do
      subject.value.should == value
    end

    it "should be valid" do
      subject.should be_valid
    end
  end

  describe "encoding parameters" do
    subject { SecureQr.new(:key => "user", :value => "data") }
    it_should_behave_like "a secured QR model", "uugOoYAe_4__GtGM6Iu88A==", "data"
  end

  describe "decoding parameters" do
    subject { SecureQr.new(:key => "user", :secured => "uugOoYAe_4__GtGM6Iu88A==") }
    it_should_behave_like "a secured QR model", "uugOoYAe_4__GtGM6Iu88A==", "data"
  end

  describe "with parameters that can't be decrypted" do
    let(:secure_qr) { SecureQr.new(:key => "wrong", :secured => "uugOoYAe_4__GtGM6Iu88A==") }

    it "is invalid" do
      secure_qr.should_not be_valid
    end

    it "value is nil" do
      secure_qr.value.should be_nil
    end
  end
end
