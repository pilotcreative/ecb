require "ecb"
require "rails"

module Ecb
  class Railtie < Rails::Railtie
    rake_tasks do
      load "ecb/tasks/ecb.rake"
    end
  end
end