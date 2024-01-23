module RSpec
  module Sidekiq
    module Matchers
      def be_dead
        BeDead.new
      end

      class BeDead
        def description
          "to be dead"
        end

        def failure_message
          "expected #{@klass} to be dead"
        end

        def failure_message_when_negated
          "expected #{@klass} to not be dead"
        end

        def matches?(job)
          @klass = job.is_a?(Class) ? job : job.class

          @klass.get_sidekiq_options.fetch("dead", false)
        end
      end
    end
  end
end
