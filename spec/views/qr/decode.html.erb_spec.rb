require 'spec_helper'

describe "qr/decode.html.erb" do
  let(:secure_qr)  { mock(SecureQr, :image_url => "http://phonyurl.com", :secured => "secured", :value => "value") }

  it "shows the original value" do
    assign(:secure_qr, secure_qr)
    render
    rendered.should have_content("value")
  end
end
