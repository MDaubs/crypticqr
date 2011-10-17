require 'spec_helper'

describe SessionsController do
  describe "POST update" do
    before do
      post :update, :password => "1234"
    end

    specify { session[:password].should == "1234" }
    it { should redirect_to root_url }
  end

  describe "POST update", "blank password" do
    before do
      post :update, :password => ""
    end

    specify { session[:password].should be_nil }
    specify { flash[:alert].should_not be_nil }
    it { should redirect_to root_url }
  end

  describe "DELETE destroy" do
    before do
      session[:password] = "1234"
      delete :destroy
    end

    specify { session[:password].should be_nil }
    it { should redirect_to root_url }
  end
end
