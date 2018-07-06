# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ruby-haml-js/version"

Gem::Specification.new do |s|
  s.name        = "ruby-haml-js"
  s.version     = RubyHamlJs::Version::VERSION
  s.authors     = ["Mark Hayes", "Dmytrii Nagirniak"]
  s.email       = ["mhayes@repairpal.com", "dnagir@gmail.com"]
  s.homepage    = "http://github.com/mhayes/ruby-haml-js"
  s.summary     = %q{Precompile HAML-JS templates with Rails assets pipeline}
  s.description = %q{ruby-haml-js provides a Tilt template that you can use to compile HAML-JS templates into JS functions. Handy for using it wth Bakcbone.js, Spine.js etc.}

  s.rubyforge_project = "ruby-haml-js"

  s.add_dependency             'sprockets', '>= 3.0.0'
  s.add_dependency             'execjs'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rails', '>= 4.2.1'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
