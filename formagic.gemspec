# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
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

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
end
