# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oktobertest'

Gem::Specification.new do |spec|
  spec.name          = 'oktobertest'
  spec.version       = Oktobertest::VERSION
  spec.authors       = ['Patricio Mac Adden']
  spec.email         = ['patriciomacadden@gmail.com']
  spec.summary       = %q{Small test library}
  spec.description   = %q{Small test library}
  spec.homepage      = 'https://github.com/patriciomacadden/oktobertest'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'rake'

  spec.add_runtime_dependency 'clap', '~> 1.0.0'
end
