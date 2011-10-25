require 'spec_helper'

describe QrController do
  describe "GET encode", "with session" do
    let(:secure_qr) { mock(SecureQr) }
    
    before do
      SecureQr.stub(:new).with(:key => "key", :value => "plaintext").and_return(secure_qr)
      secure_qr.stub(:secured).and_return("ciphertext")
      session[:password] = "key"
      get :encode, :p => "plaintext"
    end

    it { assigns(:secure_qr).should == secure_qr }
    it { assigns(:secure_url).should == decode_url + "?c=ciphertext" }
    it { should render_template("encode") }
  end

  describe "GET encode", "without session" do
    before do
      session[:password] = nil
      get :encode, :p => "plaintext"
    end

    it { should redirect_to(root_url) }
  end

  describe "GET decode", "with valid session" do
    let(:secure_qr) { mock(SecureQr, :value => "plaintext", :valid? => true) }

    before do
      SecureQr.stub(:new).with(:key => "key", :secured => "ciphertext").and_return(secure_qr)
      session[:password] = "key"
      get :decode, :c => "ciphertext"
    end

    it { assigns(:secure_qr).should == secure_qr }
    it { should render_template("decode") }
  end

  describe "GET decode", "with invalid session" do
    let(:secure_qr) { mock(SecureQr, :valid? => false) }

    before do
      SecureQr.stub(:new).with(:key => "notthekey", :secured => "ciphertext").and_return(secure_qr)
      session[:password] = "notthekey"
      get :decode, :c => "ciphertext"
    end

    it { should render_template "decode" }
  end

  describe "GET decode", "without session" do
    before do
      session[:password] = nil
      get :decode, :c => "ciphertext"
    end

    specify { session[:decode_qr_code].should == "ciphertext" }
    it { should redirect_to(root_url) }
  end
end
