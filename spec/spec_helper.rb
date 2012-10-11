$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
ROOT_PATH = File.expand_path('../..', __FILE__)
require 'rubyc'
require 'minitest/spec'
require 'minitest/autorun'
require 'rubyc/colorize_stack'

module SpecHelper  
  def new_local_io(cli, in_str)
    in_io = StringIO.new(in_str)
    out_io = StringIO.new
    @cli.in_encoder = Rubyc::StringEncoder.new(in_io)
    @cli.out_encoder = Rubyc::StringEncoder.new(out_io)
    yield
    out_io.string
  end
end
MiniTest::Unit.output.extend MiniTest::ColorizeStack