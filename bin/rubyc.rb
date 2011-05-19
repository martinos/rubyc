module ::Enumerable
  def count_by
    self.inject({}) do |memo, elem|
      key = yield elem
      memo[key] ||= 0
      memo[key] += 1
      memo
    end
  end

  def group_by
    self.inject({}) do |memo, elem|
      key = yield elem
      memo[key] ||= []
      memo[key] << elem
      memo
    end
  end

  def sum(identity = 0, &block)
    if block_given?
      map(&block).sum(identity)
    else
      inject { |sum, element| sum + element } || identity
    end
  end
end

class Rubyc < Thor
  desc :map, "Apply Enumerable#map on each line"
  def map(code)
    proc = eval( "Proc.new{|line| l = line; #{code}}" )
    STDIN.map do |line|
      puts proc.call(line).to_s
    end
  end

  desc :sum, "Calculate the sum of Numeric expressed on each line"
  def sum(code = nil)
    code ||= "line"
    proc = eval("Proc.new{|line| l = line; #{code}}")
    sum = STDIN.sum do |line|
      proc.call(line).to_f
    end
    puts sum
  end

  desc :select, "Apply Enumerable#select on each line"
  def select(code)
    proc = eval( "Proc.new{|line| l = line; #{code}}" )
    STDIN.map do |line|
      puts line if proc.call(line)
    end
  end

  desc :count_by, "Count by"
  def count_by(code = nil)
    code ||= "line"
    proc = eval( "Proc.new{|line| l = line; #{code}}" )
    counts = STDIN.count_by do |line|
      proc.call(line).chomp
    end
    puts counts.to_yaml
  end
  
  desc :uniq, "uniq"
  def uniq
    puts STDIN.to_a.uniq
  end

  desc :compact, "Remove empty lines"
  def compact
    puts STDIN.select{|line| line.strip != ""}
  end

  desc :merge, "Merge consecutive lines"
  def merge(nb_lines, sep = ",")
    STDIN.each_slice(nb_lines.to_i){|chunk| puts chunk.map{|elem| elem.strip}.join(sep) }
  end
end

Rubyc.start
