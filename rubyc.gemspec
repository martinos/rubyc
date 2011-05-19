# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rubyc/version"

Gem::Specification.new do |s|
  s.name        = "rubyc"
  s.version     = Rubyc::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Martin Chabot"]
  s.email       = ["chabotm@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Adds Ruby's powers to the command line}
  s.description = %q{Adds Ruby's powers to the command line}
  s.rubyforge_project = "rubyc"

  s.add_dependency "thor"
  s.add_dependency "minitar"
  s.add_development_dependency 'rake'
  s.add_development_dependency("bundler", "~> 1.0")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
