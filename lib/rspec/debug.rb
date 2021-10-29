require "rspec/debug/version"

return unless ['1', 'true'].include?(ENV['RSPEC_DEBUG'])

# start debug session
require 'debug/session'
DEBUGGER__::start no_sigint_hook: true, nonstop: true

module RSpec
  module Core
    class Example
      module DebugAtStop
        def initialize example_group_class, description, user_metadata, example_block=nil
          orig_example_block = example_block

          if example_block
            example_block = Proc.new do
              e = DEBUGGER__::SESSION.capture_exception_frames /(exe|bin|lib)\/rspec/ do
                self.instance_exec(&orig_example_block)
              end

              if e
                STDERR.puts <<~MSG
                Failure:
                #{e.message}
                MSG
                DEBUGGER__::SESSION.enter_postmortem_session e
                raise e
              end
            end # Proc.new
          end

          super
        end
      end

      prepend DebugAtStop
    end
  end
end
