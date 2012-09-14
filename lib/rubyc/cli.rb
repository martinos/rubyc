require 'yaml'
require 'thor'
require 'rubyc/core_extensions'

module Rubyc
  class CLI < Thor
    class_option :require, :aliases => '-r'
    
    def initialize(*args)
      super
      libs = options[:require] ? options[:require].strip.split(":") : []
      libs.each {|lib| require lib}
    end
    
    
    $stdout.sync = true
    desc :map, "Apply Enumerable#map on each line"
    def map(code)
      proc = eval( "Proc.new{|line,index| l = line; lnum = index + 1;#{code}}" )
      $stdin.each_line.each_with_index do |line, index|
        puts proc.call(line.chomp, index).to_s
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
      proc = eval( "Proc.new{|line,index| l = line; lnum = index + 1;#{code}}" )
      $stdin.each_line.each_with_index do |line, index|
        puts line if proc.call(line.chomp, index)
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
