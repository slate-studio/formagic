# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'formagic/version'

Gem::Specification.new do |s|
  s.name        = 'formagic'
  s.version     = Formagic::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Alexander Kravets']
  s.email       = 'alex@slatestudio.com'
  s.license     = 'MIT'
  s.homepage    = 'http://slatestudio.com'
  s.summary     = 'Easy to use javascript forms builder.'
  s.description = <<-DESC
This library is heavily used by Character project and provides a very
easy and convinient way to build and customize forms with javascript.
This supposed to be working with Rails on the first place.
  DESC

  s.rubyforge_project = 'formagic'

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'bourbon',         '>= 3.2'
  s.add_dependency 'normalize-rails', '>= 3.0'

  s.add_development_dependency "bundler", "~> 1.9"
  s.add_development_dependency "rake",    "~> 10.0"
end
