require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module IrisPrototype
  class Application < Rails::Application
    config.load_defaults 7.0
    config.generators.system_tests = nil
  end
end

