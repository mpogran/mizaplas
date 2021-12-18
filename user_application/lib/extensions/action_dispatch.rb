module ActionDispatch
  module Routing
    class Mapper
      module Resources
        # Allow for passing `:api_only` as a resource option.
        class Resource
          RESOURCE_OPTIONS.push(:api_only)

          alias_method :orig_init, :initialize

          def initialize(*args)
            orig_init(*args)

            @api_only ||= @options[:api_only]
          end
        end
      end
    end
  end
end
