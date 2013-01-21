require 'yaml'
require 'thor'
require 'rubyc/core_extensions'

module Rubyc
  class CLI < Thor
    class_option :require, :aliases => '-r'
    class_option :sync, :type => :boolean, :default => false, :aliases => '-s', :banner => 'Synchronize stdout'

    def initialize(*args)
      super
      libs = options[:require] ? options[:require].strip.split(":") : []
      libs.each {|lib| require lib}
      $stdout.sync = options[:sync]
    end
    
    def help(*args)
      super *args
    end

    desc "map BLOCK", "Enumerable#map"
    long_desc "THIS IS A LONG DESCRIPTION" 
    def map(code)
      proc = eval( "Proc.new{|line,index| l = line; lnum = index + 1;#{code}}" )
      $stdin.each_line.each_with_index do |line, index|
        puts proc.call(line.chomp, index).to_s
      end
    end

    desc "sum BLOCK", "Active Support Enumerable#sum"
    def sum(code = nil)
      code ||= "line"
      proc = eval("Proc.new{|line| l = line; #{code}}")
      sum = $stdin.sum do |line|
        proc.call(line.chomp)
      end
      puts sum
    end

    desc "select BLOCK", "Enumerable#select"
    def select(code)
      proc = eval( "Proc.new{|line,index| l = line; lnum = index + 1;#{code}}" )
      $stdin.each_line.each_with_index do |line, index|
        puts line if proc.call(line.chomp, index)
      end
    end

    desc "reject BLOCK", "Enumerable#reject"
    def reject(code)
      proc = eval( "Proc.new{|line,index| l = line; lnum = index + 1;#{code}}" )
      $stdin.each_line.each_with_index do |line, index|
        puts line unless proc.call(line.chomp, index)
      end
    end
    
    desc "count_by BLOCK", "Count the number of lines that have the same property. The property is defined by the return value of the given the block"
    def count_by(code = nil)
      code ||= "line"
      proc = eval("Proc.new{|line| l = line; #{code}}")
      counts = $stdin.count_by do |line|
        proc.call(line.chomp)
      end
      puts counts.to_yaml
    end

    desc "sort_by BLOCK", "Enumerable#sort_by"
    def sort_by(code = nil)
      code ||= "line"
      proc = eval("Proc.new{|line| l = line; #{code}}")
      counts = $stdin.sort_by do |line|
        proc.call(line.chomp)
      end
      puts counts
    end

    desc "grep BLOCK", "Enumerable#grep"
    def grep(pattern, code = nil)
      pattern = eval(pattern)
      proc = code ? eval("Proc.new{|line| l = line; #{code}}") : nil
      puts $stdin.grep(pattern, &proc)
    end

    desc "scan MATCHER BLOCK", "String#scan"
    def scan(pattern, code = nil)
      pattern = eval(pattern)
      proc = code ? eval("Proc.new{|*match| m = match; #{code}}") : nil
      str = $stdin.read
      str.scan(pattern, &proc)
    end

    desc "uniq", "Enumerable#uniq"
    def uniq
      puts $stdin.to_a.uniq
    end

    desc "uniq_by BLOCK", "TODO"
    def uniq_by(code = nil)
      code ||= "line"
      proc = eval("Proc.new{|line| l = line; #{code}}")
      counts = $stdin.uniq_by do |line|
        proc.call(line.chomp)
      end
      puts counts
    end

    desc "compact", "Remove empty lines"
    def compact
      $stdin.each{ |line| puts line if line.chomp! != ""}
    end

    desc "merge NB_LINES [SEPARATOR]", "Merge NB_LINES consecutive lines using SEPARATOR. If SEPARATOR is not given \',\' is used"
    def merge(nb_lines, sep = ",")
      $stdin.each_slice(nb_lines.to_i){|chunk| puts chunk.map{|elem| elem.strip}.join(sep)}
    end
  end
end
