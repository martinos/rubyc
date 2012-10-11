require 'json'

module Rubyc
  class JSONEncoder < Encoder
    def encode(obj)
      obj.to_json
    end
    
    def decode(line)
      JSON.load(line)
    end
  end
end