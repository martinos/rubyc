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
      $stdout.sync = true
    end

    desc :map, "Apply Enumerable#map on each line"
    def map(code)
      proc = proc_code code
      in_iter.each do |arg|
        puts proc.call(arg).to_s
      end
    end

    desc :select, "Apply Enumerable#select on each line"
    def select(code)
      proc = proc_code code
      in_iter.each do |line, index|
        puts line if proc.call(line, index)
      end
    end
    
    desc :sum, "Calculate the sum of Numeric expressed on each line"
    def sum(code = nil)
      code ||= "line"
      proc = proc_code code
      puts in_iter.sum(&proc)
    end

    desc :count_by, "Count the number of lines that have the same property. The property is defined by the return value of the given the block"
    def count_by(code = nil)
      code ||= "line"
      proc = proc_code code
      puts in_iter.count_by(&proc).to_yaml
    end

    desc :sort_by, "Sort by"
    def sort_by(code = nil)
      code ||= "line"
      proc = eval("Proc.new{|line| l = line; #{code}}")
      sorted = $stdin.lines.sort_by do |line|
        proc.call(line.chomp)
      end
      puts sorted
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
    
    private
    
    def in_iter
      $stdin.lines.each_with_index
    end
    
    def proc_code(code)
      str = <<EOF
      Proc.new  do |(line,index)| 
        l = line = line.chomp
        lnum = index + 1
        #{code}
      end
EOF
      eval(str)
    end
  end
end
