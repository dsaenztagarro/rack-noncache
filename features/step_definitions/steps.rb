@javascript
Given /^I open a firefox browser$/ do
  driver_for :firefox
  require 'pry'
  binding.pry
  visit '/'
  require 'pry'
  binding.pry
end
