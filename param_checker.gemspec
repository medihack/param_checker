# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "param_checker/version"

Gem::Specification.new do |s|
  s.name        = "param_checker"
  s.version     = ParamChecker::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kai Schlamp"]
  s.email       = ["schlamp@gmx.de"]
  s.homepage    = "https://github.com/medihack/param_checker"
  s.summary     = %q{Parameter parsing and validation}
  s.description = %q{A library for parameter validation and parsing. A handy way to check GET/POST params in Ruby webframeworks (like Rails or Sinatra).}

  s.rubyforge_project = "param_checker"

  s.add_development_dependency "rspec", ">= 2.0.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
