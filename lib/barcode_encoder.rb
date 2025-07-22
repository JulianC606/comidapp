class BarcodeEncoder
  START_CHAR = 204.chr('UTF-8')
  STOP_CHAR = 206.chr('UTF-8') 

  def initialize(text)
    @text = text
    unless text.ascii_only? && text.each_char.all? { |c| c.ord.between?(32, 126) }
      raise ArgumentError, "Only ASCII characters 32-126 are allowed" 
    end
  end

  def encode
    values = @text.chars.map { |c| c.ord - 32 }
    checksum = 104 + values.each_with_index.sum { |val, i| val * (i + 1) }
    checksum %= 103
    checksum_char = (checksum <= 94 ? checksum + 32 : checksum + 100).chr('UTF-8')

    "#{START_CHAR}#{@text}#{checksum_char}#{STOP_CHAR}"
  end
end