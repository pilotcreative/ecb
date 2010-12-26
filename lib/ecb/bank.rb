require "nokogiri"
require "open-uri"

module Ecb
  class Bank < Money::Bank::Base
    attr_accessor :url, :rate

    def initialize(options = {})
      self.url = {:historical => "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist.xml",
                  :daily => "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"}.merge(options[:url] || {})
      self.rate = options[:rate] || Rate
    end

    def update(options = {})
      source = send(options[:source] || :daily)
      source.xpath('gesmes:Envelope/xmlns:Cube/xmlns:Cube').each do |record|
        date = Date.parse(record.attribute("time").value)
        record.xpath(".//xmlns:Cube").each do |rate|
          value = rate.attribute("rate").value.to_f
          from = "EUR"
          to = rate.attribute("currency").value
          self.rate.new(:from => from, :to => to, :value => value, :date => date).save
        end
        self.rate.new(:from => "EUR", :to => "EUR", :value => 1.0, :date => date).save
      end
    end

    def exchange_with(from, currency, date = Date.today)
      rate = self.rate.find_for_exchange!(from.currency.to_s, currency.to_s, date)
      Money.new((from.cents * rate.value).floor, currency, Money.default_bank, date)
    end

  private

    def historical
      Nokogiri::XML(open(url[:historical]))
    end

    def daily
      Nokogiri::XML(open(url[:daily]))
    end
  end
end