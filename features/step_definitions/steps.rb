@javascript
Given /^I open a firefox browser$/ do

  driver_for :firefox
  visit '/'
  require 'pry'
  binding.pry
  # @driver.navigate.to 'http://127.0.0.1:8080'
  # binding.pry
  # firefox.navigate.to 'http://127.0.0.1:8080'
  # visit '/'
  # binding.pry
  # visit '/'
end
