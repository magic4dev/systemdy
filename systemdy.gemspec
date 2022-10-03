# frozen_string_literal: true

require_relative "lib/systemdy/version"

Gem::Specification.new do |spec|
  spec.name = "systemdy"
  spec.version = Systemdy::VERSION
  spec.authors = "magic4dev"
  spec.email = "magic4dev@gmail.com"

  spec.summary = "A lightweight gem for interact with systemd"
  spec.homepage = "https://github.com/magic4dev/systemd"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata["code_of_conduct_uri"] = "#{spec.homepage}/blob/master/CODE_OF_CONDUCT.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # dependencies of my gem
  # ....
end
