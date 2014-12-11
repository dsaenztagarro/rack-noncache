require 'rbconfig'
require 'cucumber/formatter/unicode'
require 'selenium-webdriver'
require 'pry'

require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'

require_relative 'dummy_app/application'

# Helpers for initializing selenium drivers
module SeleniumHelpers
  def firefox
    caps = Selenium::WebDriver::Remote::Capabilities.firefox
    caps.version = '5'
    caps.platform = :XP
    caps[:name] = 'Testing Selenium 2 with Ruby on Sauce'

    @driver = Selenium::WebDriver.for(
      :remote,
      # :url => 'http://username-string:access-key-string@ondemand.saucelabs.com:80/wd/hub',
      url: 'http://127.0.0.1:4444/wd/hub',
      desired_capabilities: caps)
  end
end
# Capybara.default_driver = :selenium
# Capybara.app = Rack::Builder.new do
#   use Rack::NonCache, whitelist: [Regexp.new(/(.)*/)]
#   map '/' do
#     run DummyApp
#   end
# end
#
# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, browser: :firefox)
# end

# Capybara.run_server = false

# World(Capybara)

DummyServer = Rack::Builder.new do
  # use Rack::NonCache, whitelist: [Regexp.new(/(.)*/)]
  map '/' do
    run DummyApp
  end
end.to_app

World(SeleniumHelpers)
