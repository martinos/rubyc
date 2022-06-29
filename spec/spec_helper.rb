$:.unshift File.expand_path("..", __FILE__)
$:.unshift File.expand_path("../../lib", __FILE__)
ROOT_PATH = File.expand_path("../..", __FILE__)
require "rubyc"
require "minitest/spec"
require "minitest/autorun"

module SpecHelper
  def local_io(in_str)
    old_stdin, old_stdout = $stdin, $stdout
    $stdin = StringIO.new(in_str)
    $stdout = StringIO.new
    yield
    out_str = $stdout.string
    $stdin, $stdout = old_stdin, old_stdout
    out_str
  end
end
