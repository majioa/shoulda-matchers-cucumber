require "shoulda/matchers"

module Shoulda
   module Matchers
      module Integrations
         module TestFrameworks
            # @private
            class RspecExpectations
               Integrations.register_test_framework(self, :cucumber)

               def validate!
                  return if defined?(::RSpec) && defined?(::RSpec::Matchers)

                  raise_error
               end

               def include(*modules, **_options)
                  ::RSpec::Matchers.send(:include, *modules)
               rescue NameError
                  if (require("rspec/expectations"))
                     retry
                  else
                     raise_error
                  end
               rescue LoadError
                  raise_error
               end

               def n_unit?
                  false
               end

               def present?
                  true
               end

               def raise_error
                  raise TestFrameworkNotFound, <<-EOT
You have to include the 'rspec-expectations' gem to Gemfile, and add
the line before requiring the shoulda matchers:

require 'rspec/expectations'
EOT
               end
            end
         end
      end
   end
end
