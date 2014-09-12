# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'intelli_fridge_server/version'

Gem::Specification.new do |spec|
  spec.name          = "intelli_firdge_server"
  spec.version       = IntelliFridgeServer::VERSION
  spec.authors       = ["Philipp Fehre"]
  spec.email         = ["philipp.fehre@googlemail.com"]
  spec.description   = %q{Intelli Fridge App to run on the Raspberry Pi}
  spec.summary       = %q{Records scanned barcodes in a local Couchbase Lite instance, and toggles between available and unavailable}
  spec.homepage      = "http://github.com/sideshowcoder/intelli_fridge"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
