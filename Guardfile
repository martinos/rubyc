# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'minitest' do
  watch(%r|^spec/(.*)_spec\.rb|)
  watch(%r|lib\/([^\/]+)\/([^\/]+)\.rb|)     { |m| a = "spec/#{m[2]}_spec.rb"; puts a; a}
  watch(%r|^spec/spec_helper\.rb|)    { "spec" }
end


