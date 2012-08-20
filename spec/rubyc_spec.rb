require File.expand_path('../spec_helper', __FILE__)
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'rubyc/cli'

describe "A rubyc cli" do
  before do
    @cli = Rubyc::CLI.new
  end

  it "should map stdin to stdout" do
    $stdin = StringIO.new("first\nsecond")
    $stdout = StringIO.new
    @cli.map('l.upcase')
    $stdout.string.must_equal "FIRST\nSECOND\n"
  end

  it "should select line from stdin and send it to stdout" do
    $stdin = StringIO.new("first\nsecond\nthird")
    $stdout = StringIO.new
    @cli.select('l =~ /third/')
    $stdout.string.must_equal "third\n"
  end

  it "should sum line from stdin and send it to stdout" do
    $stdin = StringIO.new("1\n2\nthird\n4")
    $stdout = StringIO.new
    @cli.sum('l.to_i * 2')
    $stdout.string.must_equal "14.0\n"
  end

  it "should sort by stdin and send the result to stdout" do
    $stdin = StringIO.new("a\nbbb\ncc\ndddd")
    $stdout = StringIO.new
    @cli.sort_by('l.length')
    $stdout.string.must_equal "a\ncc\nbbb\ndddd\n"
  end

  it "should grep stdin and send the result to stdout" do
    $stdin = StringIO.new("bbbb\nbbb\ncc\ndddd")
    $stdout = StringIO.new
    @cli.grep('/^b/', 'l.upcase') 
    $stdout.string.must_equal "BBBB\nBBB\n"
  end

  it "should count_by an algorithm and output to stdout" do
    $stdin = StringIO.new("bbbb\nbbb\ncc\ndddd")
    $stdout = StringIO.new
    @cli.count_by('l =~ /^(..)/;$1') 
    expected = {"bb" => 2, "cc" => 1, "dd" => 1}

    YAML.load($stdout.string).must_equal expected
  end
end

