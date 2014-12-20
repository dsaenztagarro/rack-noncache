require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'

Before do
  DataMapper.auto_migrate!
end

World(Capybara)
