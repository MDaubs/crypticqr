require 'spec_helper'

describe "qr/encode.html.erb" do
  it "shows a link to the contents of the QR code" do
    assign(:qr_url, "http://phonyurl.com")
    assign(:qr_input, "ciphertexttext")
    assign(:p, "plaintexttext")
    render
    rendered.should have_selector("a", :href => "http://phonyurl.com", :content => "http://phonyurl.com")
  end
end
