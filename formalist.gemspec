lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "formalist/version"

Gem::Specification.new do |spec|
  spec.name     = "formalist"
  spec.version  = Formalist::VERSION
  spec.authors  = ["Tim Riley"]
  spec.email    = ["tim@icelab.com.au"]
  spec.license  = "MIT"

  spec.summary  = "Flexible form builder"
  spec.homepage = "https://github.com/icelab/formalist"

  spec.files = Dir["README.md", "LICENSE.md", "Gemfile*", "Rakefile", "lib/**/*", "spec/**/*"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.2.0"

  spec.add_runtime_dependency "dry-configurable", "~> 0.7"
  spec.add_runtime_dependency "dry-container", "~> 0.6"
  spec.add_runtime_dependency "dry-types", "~> 0.12"
  spec.add_runtime_dependency "inflecto"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.4.2"
  spec.add_development_dependency "rspec", "~> 3.3.0"
  spec.add_development_dependency "simplecov", "~> 0.13.0"
  spec.add_development_dependency "yard"
end
