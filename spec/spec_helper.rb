$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'rubyc'
require 'minitest/spec'
require 'minitest/autorun'

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


# require 'colorize'
# 
# module ColorizeIO
#   def puts(str = "")
#     red = "\\e[31m"
#     blank = "\\e[0m"
#     green = "\\e[32m"
#     blue = "\\e[34m"
#     magenta = "\\e[35m"
#     # 
#     url_regex = %r{(\\S*.rb):(\\d+)(.*)}
#     str.each_line do |line|
#       if line =~ url_regex
#         file_name = $1
#         line_number = $2
#         complement = $3
#         if File.exist? file_name
#           full_path = File.expand_path(file_name)
#           app_trace = full_path.match(ROOT_PATH) && full_path !~ /vendor/
#           new_line = "#{blue}txmt://open?url=file://#{File.dirname(full_path)}/#{red if app_trace }#{File.basename(full_path)}#{blank}&line=#{line_number
#     }#{complement}"
#         else
#           new_line = line
#         end
#       else
#          new_line = line
#       end
#         super(new_line + "\\n")
#     end
#   end
# end
# 
# MiniTest::Unit.output.extend ColorizeIO