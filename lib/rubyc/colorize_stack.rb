module MiniTest
  # http://blog.macromates.com/2007/the-textmate-url-scheme/
  module ColorizeStack
    def write(str = "")
      str.each_line do |line|
        super(colorize_line(line))
      end
    end
    
    def colorize_line(line)
      red = "\e[31m"
      clear = "\e[0m"
      green = "\e[32m"
      blue = "\e[34m"
      magenta = "\e[35m"
      clear = "\e[0m"
      # test_0001_should_map_stdin_to_stdout(A rubyc cli) [./spec/cli_spec.rb:16]:
      # /Users/martinchabot/dev/my_gems/rubyc/spec/cli_spec.rb:16:in `test_0001_should_map_stdin_to_stdout'
      url_regex = /(.*?)([.\w\/]*.rb):(\d+)(.*)/
      if line =~ url_regex
        prefix, file_name, line_number, suffix = $1, $2, $3, $4
        if File.exist? file_name
          full_path = File.expand_path(file_name)
          app_trace = full_path.match(Dir.pwd) && full_path !~ /vendor/
          new_line = "#{prefix}#{blue}txmt://open?url=file://#{File.dirname(full_path)}/#{clear}#{red if app_trace }#{File.basename(full_path)}#{clear if app_trace}&line=#{line_number}#{suffix}\n"
        else
          new_line = line
        end
      else
         new_line = line
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
    ./lib/rubyc/colorize_stack.rb:19:in `extract_data_from_raw'
    ./lib/rubyc/colorize_stack.rb:9:in `initialize'
    ./lib/rubyc/colorize_stack.rb:44:in `new'
    ./lib/rubyc/colorize_stack.rb:44:in `parse'
    ./lib/rubyc/core_extensions.rb:18:in `parse'
    ./lib/rubyc/core_extensions.rb:17:in `map'
    ./lib/rubyc/core_extensions.rb:17:in `parse'
    ./lib/rubyc/core_extensions.rb:26:in `parse'
    ./lib/rubyc/core_extensions.rb:39:in `scanned_string'
    ./lib/rubyc/core_extensions.rb:16:in `parse'
    ./lib/rubyc/core_extensions.rb:27:in `read'
    ./spec/spec_helper.rb:8
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
  
    out = StringIO.new
    out.extend MiniTest::ColorizeStack
    out.write(str)
    str = out.string
    red = "\e\\[31m"
    clear = "\e\\[0m"
    green = "\e\\[32m"
    blue = "\e\\[34m"
    magenta = "\e\\[35m"

    assert_match %r{txmt://open\?url=file:///Users/martinchabot/dev/my_gems/rubyc/lib/rubyc/(.*)colorize_stack.rb(.*)line=19:in `extract_data_from_raw}, str
  end
end

end




