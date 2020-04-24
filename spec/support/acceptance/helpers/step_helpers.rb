require_relative 'file_helpers'
require_relative 'gem_helpers'

require 'yaml'

module AcceptanceTests
   module StepHelpers
      include FileHelpers
      include GemHelpers

      def add_rspec_expectations_to_project!
         add_gem 'rspec-expectations', rspec_expectations_version
      end

      def add_shoulda_matchers_to_project(options = {})
         AddsShouldaMatchersToProject.call(options)
      end

      def create_rails_application
         fs.clean

         command = "bundle exec rails new #{fs.project_directory} --skip-bundle --no-rc"

         run_command!(command) do |runner|
            runner.directory = nil
         end

         updating_bundle do |bundle|
            bundle.remove_gem 'turn'
            bundle.remove_gem 'coffee-rails'
            bundle.remove_gem 'uglifier'
            bundle.remove_gem 'debugger'
            bundle.remove_gem 'byebug'
            bundle.remove_gem 'web-console'
            bundle.remove_gem 'jbuilder'
            bundle.remove_gem 'sqlite3'
            bundle.remove_gem 'turbolinks'
            bundle.remove_gem 'puma'
            bundle.remove_gem 'sass-rails'
            bundle.remove_gem 'spring'
            bundle.remove_gem 'spring-watcher-listen'
            bundle.remove_gem 'capybara'
            bundle.remove_gem 'selenium-webdriver'
            bundle.remove_gem 'chromedriver-helper'
            bundle.remove_gem 'jquery-rails'
            bundle.add_gem 'pg'
            bundle.add_gem 'shoulda-matchers'
            bundle.add_gem 'cucumber-rails', { require: false }
         end

         fs.open('config/database.yml', 'w') do |file|
            YAML.dump(database.config.to_hash, file)
         end
      end
   end
end
