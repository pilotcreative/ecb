module Ecb
  class Rate
    module Persistence
      extend ActiveSupport::Concern

      class RecordNotSaved < Exception; end

      included do
        include ActiveModel::Serialization

        attr_accessor :attributes

        [:from, :to, :date, :value].each do |attribute|
          define_method(attribute){ attributes[attribute] }
          define_method("#{attribute}="){ |value| attributes[attribute] = value }
        end
      end

      module ClassMethods
        def rates
          @rates ||= []
        end

        def find_all_by_from_and_to(from, to)
          rates.select { |rate| rate.from == from.to_s and rate.to == to.to_s }
        end

        def find_by_from_and_to_and_date(from, to, date)
          rates = find_all_by_from_and_to(from, to).sort_by(&:date)
          rate = rates.select { |rate| rate.date <= date }.last || rates.first
        end

        alias find_for_exchange find_by_from_and_to_and_date
      end

      def initialize(attributes = {})
        @attributes = {:from => nil, :to => nil, :date => nil, :value => nil}.merge(attributes)
      end

      def save(*)
        create_or_update
      end

      def save!(*)
        create_or_update || raise(RecordNotSaved)
      end

      def persisted?
        self.class.rates.include?(self)
      end

    private

      def create_or_update
        result = persisted? ? update : create
        result != false
      end

      def create
        self.class.rates << self
        self
      end

      def update
        self
      end
    end
  end
end
