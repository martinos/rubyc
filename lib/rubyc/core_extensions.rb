module Enumerable
  def count_by
    self.inject({}) do |memo, elem|
      key = yield elem
      memo[key] ||= 0
      memo[key] += 1
      memo
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
