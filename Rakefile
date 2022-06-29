require 'bundler'
Bundler::GemHelper.install_tasks
Bundler.require(:default, :development)
require 'rake/testtask'

require 'cucumber'
require 'cucumber/rake/task'

require "minitest/test_task"

Minitest::TestTask.create # named test, sensible defaults

# or more explicitly:

Minitest::TestTask.create(:test) do |t|
  t.libs << "spec"
  t.libs << "lib"
  t.warning = false
  t.test_globs = ["test/**/*_spec.rb"]
end


Cucumber::Rake::Task.new(:features) do |t|
  t.fork = false
end

task :default => [:test, :features]
