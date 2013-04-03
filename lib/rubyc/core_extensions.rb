module Enumerable
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

  def uniq_by
    each_with_index.inject({}) do |memo, (obj, index)|
      val, data = yield obj
      memo[val] ||= data
      memo
    end.values
  end
end
