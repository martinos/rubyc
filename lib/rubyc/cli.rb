require 'thor'
module Rubyc
  module ::Enumerable
    def count_by
      self.inject({}) do |memo, elem|
        key = yield elem
        memo[key] ||= 0
        memo[key] += 1
        memo
      end
    end

    # This method was borrowed from ActiveSupport code
    def group_by
      self.inject({}) do |memo, elem|
        key = yield elem
        memo[key] ||= []
        memo[key] << elem
        memo
      end
    end
    
    # File activesupport/lib/active_support/core_ext/enumerable.rb, line 57
    def sum(identity = 0, &block)
      if block_given?
        map(&block).sum(identity)
      else
        inject { |sum, element| sum + element } || identity
      end
    end
  end

  class CLI < Thor
    $stdout.sync = true
    desc :map, "Apply Enumerable#map on each line"
    def map(code)
      proc = eval( "Proc.new{|line| l = line; #{code}}" )
      $stdin.each do |line|
        puts proc.call(line.chomp).to_s
      end
    end

    desc :sum, "Calculate the sum of Numeric expressed on each line"
    def sum(code = nil)
      code ||= "line"
      proc = eval("Proc.new{|line| l = line; #{code}}")
      sum = $stdin.sum do |line|
        proc.call(line.chomp).to_f
      end
      puts sum
    end

    desc :select, "Apply Enumerable#select on each line"
    def select(code)
      proc = eval("Proc.new{|line| l = line; #{code}}")
      $stdin.each do |line|
        puts line if proc.call(line.chomp)
      end
    end

    desc :count_by, "Count the number of lines that have the same property. The property is defined by the return value of the given the block"
    def count_by(code = nil)
      code ||= "line"
      proc = eval("Proc.new{|line| l = line; #{code}}")
      counts = $stdin.count_by do |line|
        proc.call(line.chomp)
      end
      puts counts.to_yaml
    end

    desc :sort_by, "Sort by"
    def sort_by(code = nil)
      code ||= "line"
      proc = eval("Proc.new{|line| l = line; #{code}}")
      counts = $stdin.sort_by do |line|
        proc.call(line.chomp)
      end
      puts counts
    end

    desc :grep, "Grep"
    def grep(pattern, code = nil)
      pattern = eval(pattern)
      proc = code ? eval("Proc.new{|line| l = line; #{code}}") : nil
      puts $stdin.grep(pattern, &proc)
    end

    desc :scan, "Scan"
    def scan(pattern, code = nil)
      pattern = eval(pattern)
      proc = code ? eval("Proc.new{|*match| m = match; #{code}}") : nil
      str = $stdin.read
      str.scan(pattern, &proc)
    end

    desc :uniq, "uniq"
    def uniq
      puts $stdin.to_a.uniq
    end

    desc :compact, "Remove empty lines"
    def compact
      $stdin.each{ |line| puts line if line.chomp! != ""}
    end

    desc :merge, "Merge consecutive lines"
    def merge(nb_lines, sep = ",")
      $stdin.each_slice(nb_lines.to_i){|chunk| puts chunk.map{|elem| elem.strip}.join(sep)}
    end
  end
end