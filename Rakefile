require 'bundler'
Bundler::GemHelper.install_tasks
Bundler.require(:default, :development)
require 'rake/testtask'

require 'cucumber'
require 'cucumber/rake/task'

Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

Cucumber::Rake::Task.new(:features) do |t|
  t.fork = false
end

task :default => [:test, :features]
