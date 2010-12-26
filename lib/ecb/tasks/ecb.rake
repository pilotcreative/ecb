require "money"

namespace :ecb do
  namespace :fetch do
    task :default => :daily

    desc "Fetch historical exchange rates"
    task :historical => :environment do
      ::Money.default_bank.update(:source => :historical)
    end

    desc "Fetch daily exchange rates"
    task :daily => :environment do
      ::Money.default_bank.update(:source => :daily)
    end
  end
end