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
end




