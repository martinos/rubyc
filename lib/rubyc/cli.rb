require 'yaml'
require 'thor'
require 'rubyc'
require 'rubyc/core_extensions'

module Rubyc
  class CLI < Thor
    class_option :require, :aliases => '-r'
    class_option :input_enc, :aliases => '-i'
    class_option :output_enc, :aliases => '-o'
    
    def initialize(*args)
      super
      libs = options[:require] ? options[:require].strip.split(":") : []
      libs.each{|lib| require lib}
      $stdout.sync = true
      
      in_enc_class = options[:input_enc] ? eval(options[:input_enc]) : StringEncoder
      out_enc_class = options[:output_enc] ? eval(options[:output_enc]) : StringEncoder

      @in_enc = in_enc_class.new($stdin)
      @out_enc = out_enc_class.new($stdout)
    end
    
    no_tasks do
      def in_encoder=(enc)
        @in_enc = enc
      end
    
      def out_encoder=(enc)
        @out_enc = enc
      end
    end
    
    def help(*args)
      super *args
    end

    desc "map BLOCK", "Enumerable#map"
    long_desc "THIS IS A LONG DESCRIPTION" 
    def map(code)
      proc = eval("Proc.new{|line,index| l = line; lnum = index + 1;#{code}}")
      
      @in_enc.each.each_with_index do |line, index|
         @out_enc.write proc.call(line, index)
      end
    end

    desc "sum BLOCK", "Active Support Enumerable#sum"
    def sum(code = nil)
      code ||= "line"
      proc = eval("Proc.new{|line| l = line; #{code}}")
      sum = @in_enc.each.sum do |line|
        proc.call(line)
      end
      @out_enc.write sum.to_s
    end

    desc "select BLOCK", "Enumerable#select"
    def select(code)
      proc = eval("Proc.new{|line,index| l = line; lnum = index + 1;#{code}}")
      @in_enc.each.each_with_index do |line, index|
        @out_enc.write line if proc.call(line.chomp, index)
      end
    end

    desc "reject BLOCK", "Enumerable#reject"
    def reject(code)
      proc = eval("Proc.new{|line,index| l = line; lnum = index + 1;#{code}}")
      @in_enc.each.each_with_index do |line, index|
        @out_enc.write line unless proc.call(line.chomp, index)
      end
    end
    
    desc "count_by BLOCK", "Count the number of lines that have the same property. The property is defined by the return value of the given the block"
    def count_by(code = nil)
      code ||= "line"
      proc = eval("Proc.new{|line| l = line; #{code}}")
      counts = @in_enc.each.count_by do |line|
        proc.call(line)
      end
      @out_enc.write counts
    end

    desc "sort_by BLOCK", "Enumerable#sort_by"
    def sort_by(code = nil)
      code ||= "line"
      proc = eval("Proc.new{|line| l = line; #{code}}")
      counts = @in_enc.sort_by do |line|
        proc.call(line)
      end
      
      counts.each{|obj| @out_enc.write(obj)}
    end

    desc "grep BLOCK", "Enumerable#grep"
    def grep(pattern, code = nil)
      pattern = eval(pattern)
      proc = code ? eval("Proc.new{|line| l = line; #{code}}") : nil
      @in_enc.grep(pattern, &proc).each{|obj| @out_enc.write obj}
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
      @in_enc.to_a.uniq.each{|obj| @out_enc.write obj}
    end

    desc "compact", "Remove empty lines"
    def compact
      @in_enc.each{|line| @out_enc.write(line) unless @in_enc.blank?(line) }
    end

    desc "merge NB_LINES [SEPARATOR]", "Merge NB_LINES consecutive lines using SEPARATOR. If SEPARATOR is not given \',\' is used"
    def merge(nb_lines, sep = ",")
      $stdin.each_slice(nb_lines.to_i){|chunk| puts chunk.map{|elem| elem.strip}.join(sep)}
    end
    
    desc "to_a", "to_a Enumerable"
    def to_a
      @out_enc.write @in_enc.to_a
    end    
  end
end
