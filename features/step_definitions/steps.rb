Given(/^a (\w+) for no caching my web application$/) do |strategy|
  @strategy = strategy
  DataMapper.auto_upgrade!
end

Given(/^I open a '(.+)' (\w+)$/) do |browser_name, browser_version|
  TestSettings.configure(browser_name: browser_name, version: browser_version,
                         strategy: @strategy)
end

Given(/^I visit the (\w+) page$/) do |page_name|
  url = case page_name
        when 'home' then '/'
        else
          '/details'
        end
  visit url
end

Given(/^I store (\d) todo tasks in session$/) do |number|
  div_xpath = "//div[@class='input-append']"
  input_el = browser.find_element xpath: "#{div_xpath}/input"
  add_btn_el = browser.find_element xpath: "//div[@class='input-append']/button"

  number.to_i.times.each do |n|
    input_el.send_keys("Task #{n}")
    add_btn_el.click
    wait_js_inactive
  end
end

When(/^I click on (.*)$/) do |text|
  browser.find_element(link_text: text).click
end

When(/^I press the (next|back) browser button$/) do |direction|
  browser.navigate.send(direction)
end

Then(/^I see the (\d) todo tasks in todo list$/) do |_|
end
