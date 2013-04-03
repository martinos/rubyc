require 'spec_helper'
require 'rubyc/cli'

include SpecHelper

describe "A rubyc cli" do
  before do
    @cli = Rubyc::CLI.new
  end

  it "should map stdin to stdout" do
    out_str = local_io("first\nsecond") do
      @cli.map('"LineNum=#{lnum} Index=#{index}: #{l.upcase}"')
    end
    out_str.must_equal "LineNum=1 Index=0: FIRST\nLineNum=2 Index=1: SECOND\n"
  end

  it "should select line from stdin and send it to stdout" do
    out_str = local_io("John Doe\nBlack Jack\nDr Dolittle\nCracker Jack") do
      @cli.select('l =~ /Jack/ && lnum == 2 && index == 1')
    end
    out_str.must_equal "Black Jack\n"
  end

  it "should reject line from stdin and send it to stdout" do
    out_str = local_io("John Doe\nBlack Jack\nDr Dolittle\nCracker Jack") do
      @cli.reject('l =~ /Jack/ && lnum == 2 && index == 1')
    end
    out_str.must_equal "John Doe\nDr Dolittle\nCracker Jack\n"
  end

  it "should sum line from stdin and send it to stdout" do
    out_str = local_io("1\n2\nthird\n4") do
      @cli.sum('l.to_i * 2')
    end
    out_str.must_equal "14\n"
  end

  it "should sort by stdin and send the result to stdout" do
    out_str = local_io("a\nbbb\ncc\ndddd") do
      @cli.sort_by('l.length')
    end
    out_str.must_equal "a\ncc\nbbb\ndddd\n"
  end

  it "should grep stdin and send the result to stdout" do
    out_str = local_io("bbbb\nbbb\ncc\ndddd") do
      @cli.grep('/^b/', 'l.upcase') 
    end
    out_str.must_equal "BBBB\nBBB\n"
  end

  it "should count_by an algorithm and output to stdout" do
    out_str = local_io("bbbb\nbbb\ncc\ndddd") do
      @cli.count_by('l =~ /^(..)/;$1') 
    end  
    expected = {"bb" => 2, "cc" => 1, "dd" => 1}

    YAML.load(out_str).must_equal expected
  end

  it "should remove empty lines from stdin and output to stdout" do
    out_str = local_io("bbbb\n\ncc\n") do 
      @cli.compact
    end
    out_str.must_equal "bbbb\ncc\n"
  end

  it "should keep unique lines from stdin and output them to stdout" do
    out_str = local_io("1\n2\n2\n3") do
      @cli.uniq
    end
    out_str.must_equal "1\n2\n3\n"
  end

  it "should keep unique records grouped by a certain algorithm" do
    out_str = local_io("aaaCoco\nbbbMomo\naaaBato\nbbbToto") do
      @cli.uniq_by('[l[0,3], l[3..-1]]')
    end
    # We test this way since uniq_by uses hashes and on Ruby 1.8.7 hashes are not ordered
    out_array = out_str.split("\n").sort
    out_array.must_equal ["Coco", "Momo"]
  end

  it "should merge lines in group of n output them to stdout" do
    out_str = local_io("1\n2\n3\n4\n5\n6\n7\n8") do
      @cli.merge(3, ",")
    end
    out_str.must_equal "1,2,3\n4,5,6\n7,8\n"
  end


  it "should merge lines in group of n output them to stdout" do
    out_str = local_io("1\n2\n3\n4\n5\n6\n7\n8") do
      @cli.merge(3, ",")
    end
    out_str.must_equal "1,2,3\n4,5,6\n7,8\n"
  end

  it "should merge lines in group of n output them to stdout" do
    out_str = local_io("1\n2\n3\n4\n5\n6\n7\n8") do
      @cli.merge(3, ",")
    end
    out_str.must_equal "1,2,3\n4,5,6\n7,8\n"
  end
end

