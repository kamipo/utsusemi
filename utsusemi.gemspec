# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'utsusemi/version'

Gem::Specification.new do |spec|
  spec.name          = "utsusemi"
  spec.version       = Utsusemi::VERSION
  spec.authors       = ["Ryuta Kamizono"]
  spec.email         = ["kamipo@gmail.com"]

  spec.summary       = %q{Utsusemi is a soft deleted as efficiently approach.}
  spec.description   = %q{Utsusemi is a soft deleted as efficiently approach.}
  spec.homepage      = "https://github.com/kamipo/utsusemi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "mysql2", ">= 0.3.18"
  spec.add_runtime_dependency "activesupport", "~> 4.0"
  spec.add_runtime_dependency "activerecord", "~> 4.0"
end
