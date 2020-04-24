
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "shoulda/matchers/cucumber/version"

Gem::Specification.new do |spec|
   spec.name               = "shoulda-matchers-cucumber"
   spec.version          = Shoulda::Matchers::Cucumber::VERSION
   spec.authors          = ["Malo Skrylevo"]
   spec.email             = ["majioa@yandex.ru"]

   spec.summary          = %q{Use rspec-expectations directly in cucumber }
   spec.description    = %q{The gem to be used to support the rspec expectation syntax in the cucumber step methods, without picking up the whole rspec}
   spec.homepage         = "https://github.com/majioa/shoulda-matchers-cucumber"
   spec.license          = "MIT"

   # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
   # to allow pushing to a single host or delete this section to allow pushing to any host.
   if spec.respond_to?(:metadata)
      spec.metadata["allowed_push_host"] = "https://rubygems.com"

      spec.metadata["homepage_uri"] = spec.homepage
      spec.metadata["source_code_uri"] = "https://github.com/majioa/shoulda-matchers-cucumber"
      spec.metadata["changelog_uri"] = "https://github.com/majioa/shoulda-matchers-cucumber/CHANGELOG.md"
   else
      raise "RubyGems 2.0 or newer is required to protect against " \
         "public gem pushes."
   end

   # Specify which files should be added to the gem when it is released.
   # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
   spec.files             = Dir.chdir(File.expand_path('..', __FILE__)) do
      `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
   end
   spec.bindir            = "exe"
   spec.executables    = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
   spec.require_paths = ["lib"]

   spec.add_development_dependency "bundler", "~> 2.0"
   spec.add_development_dependency "rake", "~> 13.0"
   spec.add_development_dependency "rspec", "~> 3.0"
   spec.add_development_dependency "pry", "~> 0.13.1"
   spec.add_development_dependency "rails", "~> 5.0.0"
   spec.add_development_dependency "pg", "~> 1.2.3"
   spec.add_development_dependency "bootsnap", "~> 1.4.6"
   spec.add_development_dependency "listen", "~> 3.0.5"
   spec.add_development_dependency "cucumber-rails", "~> 2.0"
   spec.add_runtime_dependency "shoulda-matchers", ">= 3.0.0", "< 5.0.0"
   spec.add_runtime_dependency "cucumber", "~> 3.0"
   spec.add_runtime_dependency "rspec-expectations", "~> 3.0"
end
