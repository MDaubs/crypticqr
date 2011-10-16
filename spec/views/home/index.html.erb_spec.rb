require 'spec_helper'

describe "home/index.html.erb" do
  describe "without a session password set" do
    before do
      session[:password] = nil
      render
    end

    it "should render a form to enter a new password" do
      rendered.should have_selector("form[action='#{session_path}']")
    end

    it "should render a password field" do
      rendered.should have_selector("input[id='password'][name='password'][type='text']")
    end

    it "should render instructions for entering a new password" do
      rendered.should have_selector("div.instructions", :content => "Enter a password")
    end
  end

  describe "with a session password set" do
    before do
      session[:password] = "1234"
      render
    end

    it "should render a form to encode a new QR code" do
      rendered.should have_selector("form[action='#{encode_path}']")
    end

    it "should render a text field called p" do
      rendered.should have_selector("input[id='p'][name='p'][type='text']")
    end

    it "should render a button to clear the current password" do
      rendered.should have_selector("form[action='#{session_path}']")
      rendered.should have_selector("input[type='submit']")
      rendered.should have_selector("input[type='hidden'][name='_method'][value='delete']")
    end
  end
end
