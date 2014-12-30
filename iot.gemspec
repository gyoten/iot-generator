# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iot/version'

Gem::Specification.new do |spec|
  spec.name          = "iot"
  spec.version       = Iot::VERSION
  spec.authors       = ["Akito Gyoten"]
  spec.email         = ["akitogyoten@gmail.com"]
  spec.summary       = %q{Development environment for IoT devices generator}
  spec.description   = %q{IoT gem generate development environment for IoT devices and genarate skelton code for embedded software for IoT devices.}
  spec.homepage      = "http://corp.strobo.me"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
