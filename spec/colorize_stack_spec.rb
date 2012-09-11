require 'spec_helper'
require 'stringio'

  
describe MiniTest::ColorizeStack do
  it 'shoud colorize IO' do
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
    str.must_match %r{txmt://open\?url=file:///(.*)rubyc/lib/rubyc/(.*)colorize_stack.rb(.*)line=19:in `extract_data_from_raw}
  end
end
