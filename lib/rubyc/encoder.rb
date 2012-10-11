module Rubyc
  class Encoder
    include Enumerable
    
    def initialize(io)
      @io = io
    end
    
    def write(obj)
      @io.puts encode(obj)
    end
  
    def read
      line = @io.read
      decode(line.chomp)
    end
  
    def each
      if block_given?
        @io.each_line do |line|
          yield decode(line.chomp)
        end
      else
        Enumerator.new(self)
      end
    end
  end
end