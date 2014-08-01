$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require "magnitude/version"

Gem::Specification.new do |spec|
  spec.name         = "magnitude"
  spec.version      = Magnitude::VERSION
  spec.authors      = ["Pavel Pravosud"]
  spec.email        = ["pavel@pravosud.com"]
  spec.summary      = "Represent scientific magnitudes in ruby value objects"
  spec.homepage     = "https://github.com/rwz/magnitude"
  spec.license      = "MIT"
  spec.files        = `git ls-files -z`.split("\x0")
  spec.test_files   = spec.files.grep(/^spec\//)
  spec.require_path = "lib"
end
