require_relative 'gem_helpers'

module AcceptanceTests
   module RspecHelpers
      include GemHelpers

      def rspec_expectations_version
         bundle_version_of('rspec-expectations')
      end
   end
end
