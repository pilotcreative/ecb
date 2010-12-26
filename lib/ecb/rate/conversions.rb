module Ecb
  class Rate
    module Conversions
      extend ActiveSupport::Concern

      module ClassMethods
        def find_by_from_and_to_and_date_with_conversion(from, to, date = Date.today)
          original = find_by_from_and_to_and_date(from, to, date)
          computed = convert(find_by_from_and_to_and_date("EUR", from, date), find_by_from_and_to_and_date("EUR", to, date), date) unless original.try(:date) == date
          [original, computed].compact.max.try(:tap){ |rate| rate.save unless rate.persisted? }
        end

      private

        alias find_for_exchange find_by_from_and_to_and_date_with_conversion

        def convert(from, to, date)
          return unless from and to and date
          rate = self.new(:from => from.to.to_s, :to => to.to.to_s, :date => [from.date, to.date].max, :value => to.value / from.value)
          rate if rate.valid?
        end
      end
    end
  end
end