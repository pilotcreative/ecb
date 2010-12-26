require "ecb/rate/persistence"
require "ecb/rate/base"

class Ecb::Rate
  include Ecb::Rate::Persistence
  include Ecb::Rate::Base
end