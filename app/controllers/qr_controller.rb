class QrController < ApplicationController
  def encode
    if session[:password]
      @qr_input = Base64.urlsafe_encode64(encrypt(params[:p]))
      @qr_url   = CGI.escape("#{decode_url}?c=") + @qr_input
    else
      raise "You must specify a password before encoding a QR code."
    end
  end

  def decode
    if session[:password]
      @qr_output = decrypt(Base64.urlsafe_decode64(params[:c]))
    else
      raise "You must specify a password before encoding a QR code."
    end
  end

  private

  def aes(m,k,t)
    (aes = OpenSSL::Cipher::Cipher.new('aes-256-cbc').send(m)).key = Digest::SHA256.digest(k)
    aes.update(t) << aes.final
  end

  def encrypt(plaintext)
    aes(:encrypt, session[:password], plaintext)
  end

  def decrypt(ciphertext)
    aes(:decrypt, session[:password], ciphertext)
  end
end
