module Rubyc
  class StringEncoder < Encoder
    def encode(obj)
      obj.to_s
    end
    
    def decode(str)
      str
    end

    def blank?(str)
      str.chomp == ""
    end
  end
end