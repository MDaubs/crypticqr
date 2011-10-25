class SecureQr

  def initialize(parameters)
    @key     = parameters[:key]
    @value   = parameters[:value]
    @secured = parameters[:secured]
  end

  def image_url
    "http://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=#{secured}"
  end

  def secured
    @secured ||= Aes.encrypt(@value).with(@key).to_s
  end

  def value
    begin
      @value ||= Aes.decrypt(@secured).with(@key).to_s
    rescue
      @value = nil
    end
  end

  def valid?
    begin
      value.present?
    rescue
      false
    end
  end
end
