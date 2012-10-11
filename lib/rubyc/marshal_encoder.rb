require 'base64'

module Rubyc
  class MarshalEncoder < Encoder
    def encode(obj)
      Base64.strict_encode64(Marshal.dump(obj))
    end

    def decode(str)
      Marshal.load(Base64.strict_decode64(str.chomp))
    end

    def blank?(obj)
      obj.nil?
    end
  end
end
