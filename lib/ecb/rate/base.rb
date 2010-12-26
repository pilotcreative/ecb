require "active_support/concern"
require "ecb/rate/finder"
require "ecb/rate/comparable"
require "ecb/rate/conversions"
require "ecb/rate/validations"

module Ecb
  class Rate
    module Base
      extend ActiveSupport::Concern

      included do
        include Ecb::Rate::Finder
        include Ecb::Rate::Validations
        include Ecb::Rate::Conversions
        include Ecb::Rate::Comparable
      end
    end
  end
end
