require "active_model/validations"
require "active_support/concern"

module Ecb
  class Rate
    module Validations
      extend ActiveSupport::Concern

      class RecordInvalid < Exception; end

      included do
        include ActiveModel::Validations

        validates :from, :presence => true
        validates :to, :presence => true
        validates :date, :presence => true
        validates :value, :presence => true, :numericality => true
      end

      def save(options = {})
        perform_validations(options) ? super : false
      end

      def save!(options = {})
        perform_validations(options) ? super : raise(RecordInvalid.new(self))
      end

    protected

      def perform_validations(options={})
        perform_validation = options[:validate] != false
        perform_validation ? valid?(options[:context]) : true
      end
    end
  end
end