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
              begin
                postmortem_hook = TracePoint.new(:raise){|tp|
                  exc = tp.raised_exception
                  frames = DEBUGGER__.capture_frames(nil)
                  frames.delete_if{|e| /(exe|bin|lib)\/rspec/ =~ e.path}
                  exc.instance_variable_set(:@__debugger_postmortem_frames, frames)
                }

                postmortem_hook.enable
                begin
                  self.instance_eval(&orig_example_block)
                ensure
                  postmortem_hook.disable
                end

              rescue Exception => e
                STDERR.puts "Failure:"
                STDERR.puts e.message
                DEBUGGER__::SESSION.enter_postmortem_session e
                raise
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

