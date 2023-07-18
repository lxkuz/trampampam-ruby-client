# frozen_string_literal: true

require_relative "lib/contactpay/version"

Gem::Specification.new do |spec|
  spec.name = "contactpay"
  spec.version = Contactpay::VERSION
  spec.authors = ["Alexey Kuznetsov"]
  spec.email = ["a.kuznetsov@okft.io"]

  spec.summary = "Ruby Client of Contactpay API"
  spec.description = "Ruby Client of Contactpay API"
  spec.homepage = "https://contactpay.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/lxkuz/contactpay-ruby-client"
  spec.metadata["changelog_uri"] = "https://github.com/lxkuz/contactpay-ruby-client/blob/main/CHANGELOG.md"
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_dependency "faraday", "~> 1.0"
  spec.add_development_dependency "pry", "~> 0.12"
  spec.add_development_dependency "vcr", "~> 5.1"
  spec.add_development_dependency "webmock", "~> 3.18"
  spec.add_development_dependency "timecop", "~> 0.9"
  spec.metadata["rubygems_mfa_required"] = "true"
end
