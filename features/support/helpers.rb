module CucumberHelpers
  def browser
    page.driver.browser
  end

  def wait_js_inactive
    Selenium::WebDriver::Wait.new.until do
      browser.execute_script('return jQuery.active') == 0
    end
  end
end

World(CucumberHelpers)
