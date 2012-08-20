$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'rubyc'
require 'minitest/spec'
require 'minitest/autorun'



module SpecHelper
  def validate_attr(fields, expected)
    fields.each_with_index do |field, index| 
      field.name.must_equal(expected[index][0])
      field.value.must_equal(expected[index][1])
    end
  end
end
