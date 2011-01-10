# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "raylayers/version"

Gem::Specification.new do |s|
  s.name        = "raylayers"
  s.version     = Raylayers::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Fabio R. Panettieri"]
  s.email       = ["fpanettieri@xoomcode.com"]
  s.homepage    = "http://www.xoomcode.com/projects/raylayers"
  s.summary     = %q{OpenLayers for Rails}
  s.description = %q{"This gem provides a Rails generator to install OpenLayers into your Rails 3 app}

  s.rubyforge_project = "raylayers"

  s.add_dependency "rubyzip", "~> 0.9.4"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
