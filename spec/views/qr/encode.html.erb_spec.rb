require 'spec_helper'

describe "qr/encode.html.erb" do
  let(:secure_qr)  { mock(SecureQr, :image_url => "http://phonyurl.com", :secured => "secured", :value => "value") }
  let(:secure_url) { "http://destinationdecodeurl.com" }

  it "shows a link to the contents of the QR code" do
    assign(:secure_qr, secure_qr)
    assign(:secure_url, secure_url)
    render
    #assign(:qr_url, "http://phonyurl.com")
    #assign(:qr_input, "ciphertexttext")
    #assign(:p, "plaintexttext")
    #render
    rendered.should have_selector("a", :href => "http://destinationdecodeurl.com", :content => "http://destinationdecodeurl.com")
  end
end
