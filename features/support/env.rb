require 'rbconfig'
require 'cucumber/formatter/unicode'
require 'pry'

require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'

Capybara.default_driver = :selenium
Capybara.app = Rack::Builder.new do
  use Rack::NonCache, whitelist: [Regexp.new(/(.)*/)]
  map '/' do
    run DummyApp
  end
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

Capybara.run_server = false

World(Capybara)
