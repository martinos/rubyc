module MiniTest
  # http://blog.macromates.com/2007/the-textmate-url-scheme/
  module ColorizeStack
    def write(str = "")
      red = "\e[31m"
      clear = "\e[0m"
      green = "\e[32m"
      blue = "\e[34m"
      magenta = "\e[35m"
      clear = "\e[0m"
      # test_0001_should_map_stdin_to_stdout(A rubyc cli) [./spec/cli_spec.rb:16]:
      # /Users/martinchabot/dev/my_gems/rubyc/spec/cli_spec.rb:16:in `test_0001_should_map_stdin_to_stdout'
      url_regex = /(.*?)([.\w\/]*.rb):(\d+)(.*)/
      str.each_line do |line|
        if line =~ url_regex
          prefix = $1
          file_name = $2
          line_number = $3
          complement = $4
          if File.exist? file_name
            full_path = File.expand_path(file_name)
            app_trace = full_path.match(Dir.pwd) && full_path !~ /vendor/
            new_line = "#{prefix}#{blue}txmt://open?url=file://#{File.dirname(full_path)}/#{clear}#{red if app_trace }#{File.basename(full_path)}#{clear if app_trace}&line=#{line_number
      }#{complement}\n"
          else
            new_line = line
          end
        else
           new_line = line
        end
          super(new_line)
      end
    end
  end
  class StackColor < Delegator
    def initialize(obj)
      super        
      @delegate_obj = obj
    end

    def __getobj__
      @delegate_obj
    end

    def __setobj__(obj)
      @delegate_obj = obj
    end
    
    def write(str = "")
      red = "\e[31m"
      clear = "\e[0m"
      green = "\e[32m"
      blue = "\e[34m"
      magenta = "\e[35m"
      clear = "\e[0m"
      puts " sadfasdfasdfSsadfkh 9009999998"
      # test_0001_should_map_stdin_to_stdout(A rubyc cli) [./spec/cli_spec.rb:16]:
      # /Users/martinchabot/dev/my_gems/rubyc/spec/cli_spec.rb:16:in `test_0001_should_map_stdin_to_stdout'
      url_regex = /(.*?)([.\w\/]*.rb):(\d+)(.*)/
      str.each_line do |line|
        if line =~ url_regex
          prefix = $1
          file_name = $2
          line_number = $3
          complement = $4
          if File.exist? file_name
            full_path = File.expand_path(file_name)
            app_trace = full_path.match(Dir.pwd) && full_path !~ /vendor/
            new_line = "#{prefix}#{blue}txmt://open?url=file://#{File.dirname(full_path)}/#{clear}#{red if app_trace }#{File.basename(full_path)}#{clear if app_trace}&line=#{line_number
      }#{complement}\n"
          else
            new_line = line
          end
        else
           new_line = line
        end
          @delegate_obj.write(new_line)
      end
    end
  end
end

if __FILE__ == $0 
  
  ### Test does not pass yet
require 'minitest/unit'
require 'minitest/autorun'
require 'stringio'

class ColorizeStackTest < MiniTest::Unit::TestCase
  def test_colorize_stack
    str = <<EOF
test_0003_should_return_the_value_from_on_key(AProductionBafFileSpec::AStructureSpec):
RuntimeError: THIS IS A STACKTRACE TEST
    ./lib/rubyc/field.rb:19:in `extract_data_from_raw'
    ./lib/rubyc/field.rb:9:in `initialize'
    ./lib/rubyc/field.rb:44:in `new'
    ./lib/rubyc/field.rb:44:in `parse'
    ./lib/rubyc/structure.rb:18:in `parse'
    ./lib/rubyc/structure.rb:17:in `map'
    ./lib/rubyc/structure.rb:17:in `parse'
    ./lib/rubyc/record.rb:26:in `parse'
    ./lib/rubyc/helper.rb:39:in `scanned_string'
    ./lib/rubyc/record.rb:16:in `parse'
    ./lib/rubyc/file.rb:27:in `read'
    ./spec/file_spec.rb:8
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/spec.rb:118:in `instance_eval'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/spec.rb:118:in `setup'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:713:in `run'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:675:in `run_test_suites'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:669:in `each'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:669:in `run_test_suites'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:668:in `each'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:668:in `run_test_suites'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:632:in `run'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:524:in `autorun'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352@global/gems/rake-0.8.7/lib/rake/rake_test_loader.rb:5

5 tests, 0 assertions, 0 failures, 5 errors, 0 skips
EOF
  
    stdout = StringIO.new
    Minitest::ColorizeStack
    stdout.extend Minitest::ColorizeStack
    stdout.write(str)
    stdout.print str
    str = stdout.string
    red = "\e[31m"
    clear = "\e[0m"
    green = "\e[32m"
    blue = "\e[34m"
    magenta = "\e[35m"

    puts "File exist tab"  if File.exist?("./lib/coco_gem/field.rb")
    assert_match %{#{blue}txmt://open?url=file:///.*/lib/coco_gem/#{clear}#{red}field.rb#{clear}:19:in `extract_data_from_raw'}, str
    
  end
end

end




