require 'spec_helper'

describe Aes do
  it "decrypts ciphertext generated from encrypted plaintext" do
    ciphertext = Aes.encrypt("plaintext").with("key")
    plaintext  = Aes.decrypt(ciphertext).with("key")
    plaintext.to_s.should == "plaintext"
  end
end
