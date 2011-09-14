# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stock-returns/version"

Gem::Specification.new do |s|
  s.name        = "stock-returns"
  s.version     = StockReturns::VERSION
  s.authors     = ["Steve Morris"]
  s.email       = ["github@stevemorris.com"]
  s.homepage    = "https://github.com/stevemorris"
  s.summary     = %q{Calculates returns on stocks}
  s.description = %q{Alpha version of a gem to calculate returns on stocks
    in a variety of ways.}

  s.rubyforge_project = "stock-returns"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "money"
end
