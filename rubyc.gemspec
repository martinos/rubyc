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
  s.summary     = %q{Adds ruby power to the command line}
  s.description = %q{Adds ruby power to the command line}

  s.rubyforge_project = "rubyc"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
