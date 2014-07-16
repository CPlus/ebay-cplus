# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ebay/version'

Gem::Specification.new do |spec|
  spec.name          = "ebay"
  spec.version       = Ebay::VERSION
  spec.authors       = ["Laszlo Bacsi"]
  spec.email         = ["lackac@lackac.hu"]
  spec.description   = %q{Lean eBay Trading API client. It implements only a few methods of the API, the ones that we need for CollectPlus.}
  spec.summary       = %q{Lean eBay Trading API client}
  spec.homepage      = "https://github.com/CPlus/ebay-cplus"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "savon", "~> 2.0"
  spec.add_dependency "hashie", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
