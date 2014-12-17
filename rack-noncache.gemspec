# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/noncache/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack-noncache'
  spec.version       = Rack::NonCache::VERSION
  spec.authors       = ['David Saenz Tagarro']
  spec.email         = ['david.saenz.tagarro@gmail.com']
  spec.summary       = 'HTTP Non browser caching for Rack'
  spec.description   = 'Rack::NonCache is a rack middleware that disables HTTP browser caching.'
  spec.homepage      = 'https://github.com/dsaenztagarro/rack-noncache'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'cane'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'selenium-webdriver'
  spec.add_development_dependency 'simplecov'

  # Dummy app dependencies
  spec.add_development_dependency 'sinatra'
  spec.add_development_dependency 'sinatra-contrib'
  spec.add_development_dependency 'dm-sqlite-adapter'
  spec.add_development_dependency 'datamapper'
end
