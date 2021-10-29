require_relative 'lib/rspec/debug/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-debug"
  spec.version       = RSpec::Debug::VERSION
  spec.authors       = ["Koichi Sasada"]
  spec.email         = ["ko1@atdot.net"]

  spec.summary       = %q{invoke debugger if spec fails}
  spec.description   = %q{invoke debugger if spec fails}
  spec.homepage      = "https://github.com/ko1/rspec-debug"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency 'debug', '>= 1.3.3'
end
