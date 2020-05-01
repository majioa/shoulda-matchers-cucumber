require 'acceptance_spec_helper'

RSpec.describe 'shoulda-matchers integrates libs for cucumber framework' do
   before do
      create_rails_application

      write_file 'db/migrate/1_create_users.rb', <<-FILE
         class CreateUsers < ActiveRecord::Migration
            def self.up
               create_table :users do |t|
                  t.string :name
               end
            end
         end
      FILE

      run_rake_tasks(*%w(db:drop))
      run_rake_tasks!(*%w(db:create db:migrate))

      write_file 'app/models/user.rb', <<-FILE
         class User < ActiveRecord::Base
            validates_presence_of :name
            validates_uniqueness_of :name
         end
      FILE

      write_file 'features/support/env.rb', <<-FILE
      require 'cucumber/rails'
      require 'shoulda-matchers/cucumber'

      Shoulda::Matchers.configure do |config|
         config.integrate do |with|
            with.test_framework :cucumber
            with.library :active_model
            with.library :active_record ;end;end
      FILE

      write_file 'lib/tasks/cucumber.rake', <<-FILE
      require 'cucumber/rake/task'

      Cucumber::Rake::Task.new(:cucumber) do |t|
         t.cucumber_opts = "features --format pretty"
      end
      FILE

      write_file 'features/step_definitions/user_model_steps.rb', <<-FILE
      Given("default User model") do
         User.create(name: "Vasja")
      end

      Then("the model is valid") do
         expect(User.first).to validate_presence_of(:name)
      end
      FILE

      write_file 'features/user_model.feature', <<-FILE
      Feature: User model

      Scenario: Valid model of User
         Given default User model
         Then the model is valid
      FILE

      updating_bundle do
         add_rspec_expectations_to_project!
         add_shoulda_matchers_to_project(
            test_frameworks: [:cucumber],
            libraries: [:active_record, :active_model],
         )
      end
   end

   context 'when using both active_record and active_model libraries' do
      it 'allows the use of matchers from both libraries' do
         result = run_rake_tasks 'cucumber'
         expect(result).to have_output('2 passed')
      end
   end

   context 'when no rspec-expectation gem is included' do
      before do
         updating_bundle do |bundle|
            bundle.remove_gem 'rspec-expectations'
            bundle.add_gem 'rspec-expectations', { require: false }
         end
      end

      it 'autorequire it' do
         result = run_rake_tasks 'cucumber'
         expect(result).to have_output('2 passed')
      end
   end
end
