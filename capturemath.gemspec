# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capturemath/version'

Gem::Specification.new do |spec|
  spec.name          = "capturemath"
  spec.version       = Capturemath::VERSION
  spec.authors       = ["Ashish Sehra"]
  spec.email         = ["asehra@gmail.com"]
  spec.description   = %q{A gem that can be used to interact with a mathML to svg/png conversion server (https://github.com/quipper/svgtex). }
  spec.summary       = %q{A gem that can be used to interact with a mathML to svg/png conversion server (https://github.com/quipper/svgtex). }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "rake"
end
