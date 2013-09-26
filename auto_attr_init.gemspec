# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'auto_attr_init/version'

Gem::Specification.new do |spec|
  spec.name          = 'auto_attr_init'
  spec.version       = AutoAttrInit::VERSION
  spec.authors       = ['ne_Sachirou']
  spec.email         = ['utakata.c4se@gmail.com']
  spec.description   = %q{Dart like "automatic field initialization" in Ruby.}
  spec.summary       = %q{Dart-lang's constructor has "automatic field initialization". I implement a similar one in Ruby.}
  spec.homepage      = 'https://github.com/ne-sachirou/AutoAttrInit.rb'
  spec.license       = 'Public Domain'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'aspectr'
  spec.add_dependency 'sorcerer'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'test-unit'
end
