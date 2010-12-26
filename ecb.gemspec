# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ecb/version"

Gem::Specification.new do |s|
  s.name        = "ecb"
  s.version     = Ecb::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mateusz Drożdżyński"]
  s.email       = ["gems@objectreload.com"]
  s.homepage    = "http://github.com/objectreload/ecb"
  s.summary     = %q{European Central Bank for the Money gem}

  s.rubyforge_project = "ecb"

  s.add_dependency "money", ">= 3.5.4"
  s.add_dependency "activesupport", ">= 3.0.3"
  s.add_dependency "activemodel", ">= 3.0.3"
  s.add_dependency "nokogiri", "= 1.4.2"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
