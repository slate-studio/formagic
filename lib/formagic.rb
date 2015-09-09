require 'normalize-rails'
require 'bourbon'

module Formagic
  class Engine < ::Rails::Engine
    require 'formagic/engine'
  end
end
