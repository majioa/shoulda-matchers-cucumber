require_relative 'base_helpers'
require_relative '../../tests/command_runner'

module AcceptanceTests
   module CommandHelpers
      extend RSpec::Matchers::DSL

      def run_command(*args)
         Tests::CommandRunner.run(*args) do |runner|
            runner.directory = fs.project_directory
            yield runner if block_given?
         end
      end

      def run_command!(*args)
         run_command(*args) do |runner|
            runner.run_successfully = true
            yield runner if block_given?
         end
      end

      def append_rake_task(task, depends_on, code)
         file = File.join(fs.project_directory, 'Rakefile')
         if IO.read(file).split("\n").grep("task :#{task}").empty?
            depend_line = [depends_on].flatten.map { |x| ":#{x}" }.join(', ')
            task_code = <<-CODE
task :#{task} => [ #{depend_line} ] do
   #{code.strip}
end
            CODE
            append_to_file file, task_code
         end
      end

      def run_command_isolated_from_bundle(*args)
         run_command(*args) do |runner|
            runner.around_command do |run_command|
               Bundler.with_unbundled_env(&run_command)
            end

            yield runner if block_given?
         end
      end

      def run_command_within_bundle(*args)
         #run_command_isolated_from_bundle(*args) do |runner|
         run_command(*args) do |runner|
            runner.command_prefix = "bundle exec"
            runner.env['BUNDLE_GEMFILE'] = fs.find_in_project('Gemfile').to_s
            #$stderr.puts(ENV.keys.grep(/GEM/).reduce({}) { |res, key| res.merge({key => ENV[key]}) }.inspect)
            #runner.env['GEM_HOME'] = ENV['BUNDLER_ORIG_GEM_HOME'] if "#{ENV['BUNDLER_ORIG_GEM_HOME']}" !~ /NIL/
            #runner.env['GEM_PATH'] = ENV['BUNDLER_ORIG_GEM_PATH'] if "#{ENV['BUNDLER_ORIG_GEM_PATH']}" !~ /NIL/
            #$stderr.puts(runner.env.keys.grep(/GEM/).reduce({}) { |res, key| res.merge({key => runner.env[key]}) }.inspect)

            yield runner if block_given?
         end
      end

      def run_command_within_bundle!(*args)
         run_command_within_bundle(*args) do |runner|
            runner.run_successfully = true
            yield runner if block_given?
         end
      end

      def run_rake_tasks(*tasks)
         options = tasks.last.is_a?(Hash) ? tasks.pop : {}
         args = ['rake', *tasks, '--trace'] + [options]
         run_command_within_bundle(*args)
      end

      def run_rake_tasks!(*tasks)
         options = tasks.last.is_a?(Hash) ? tasks.pop : {}
         args = ['rake', *tasks, '--trace'] + [options]
         run_command_within_bundle!(*args)
      end
   end
end
