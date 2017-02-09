# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opensaz/version'

Gem::Specification.new do |spec|
  spec.name          = "opensaz"
  spec.version       = Opensaz::VERSION
  spec.authors       = ["Cong Yang"]
  spec.email         = [""]

  spec.summary       = %q{a handy tool to read from .saz file.}
  spec.description   = %q{a handy tool to read from .saz file(package captured by Fiddler).}
  spec.homepage      = "https://github.com/keegoo/opensaz"
  spec.license       = "MIT"

  spec.files         = Dir.glob("lib/**/*") + %w(README.md LICENSE.txt)
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_runtime_dependency 'rubyzip'
  spec.add_runtime_dependency 'nokogiri'
end
