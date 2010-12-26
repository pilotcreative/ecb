require "active_support/concern"
require "money"

module Ecb
  class Rate
    module Finder
      extend ActiveSupport::Concern

      module ClassMethods
        def find_for_exchange(*arguments)
          raise ::Money::Bank::NotImplementedError, "#find_for_exchange must be implemented"
        end

        def find_for_exchange!(from, to, date)
          find_for_exchange(from, to, date) || raise(::Money::Bank::UnknownRate, "No conversion rate known for '#{from}' -> '#{to}'")
        end
      end
    end
  end
end
