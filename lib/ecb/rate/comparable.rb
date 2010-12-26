require "active_support/concern"

module Ecb
  class Rate
    module Comparable
      extend ActiveSupport::Concern

      def <=>(rate)
        [self.from, self.to, self.date] <=> [rate.from, rate.to, rate.date]
      end
    end
  end
end

