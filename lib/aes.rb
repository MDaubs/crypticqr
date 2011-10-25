class Aes
  def self.encrypt(plaintext)
    Aes.new(:plaintext => plaintext)
  end

  def self.decrypt(ciphertext)
    Aes.new(:ciphertext => Base64.urlsafe_decode64(ciphertext.to_s))
  end

  def with(key)
    @key = key
    self
  end

  def to_s
    if @plaintext
      Base64.urlsafe_encode64(aes(:encrypt, @key, @plaintext))
    elsif @ciphertext
      aes(:decrypt, @key, @ciphertext)
    else
      raise "Expecting either plaintext or ciphertext but neither was found."
    end
  end

  private

  def aes(m,k,t)
    (aes = OpenSSL::Cipher::Cipher.new('aes-256-cbc').send(m)).key = Digest::SHA256.digest(k)
    aes.update(t) << aes.final
  end

  def initialize(options)
    @plaintext  = options[:plaintext]
    @ciphertext = options[:ciphertext]
  end
end
