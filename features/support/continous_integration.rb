require_relative 'capybara_selenium'
# require 'capybara-selenium'

# Helpers for accessing configuration option
module ContinousIntegration
  def app_server(opts = {})
    {
      host: ENV['CI_APP_SERVER_HOST'] || 'localhost',
      port: ENV['CI_APP_SERVER_PORT'] || 8080,
      type: :rack,
      config_ru_path: ENV['CI_APP_SERVER_CONFIG_RU'] || config_ru_path
    }.merge(opts)
  end

  def selenium_server(opts = {})
    {
      type: :remote,
      url: ENV['CI_SELENIUM_SERVER_URL'] || 'http://127.0.0.1:4444/wd/hub',
      capabilities: {
        browser_name: :firefox
      }
    }.merge(opts)
  end

  def driver_for(browser_name)
    CapybaraSelenium::GlobalConfigurator.new(
      app_server: app_server,
      selenium_server: selenium_server.merge(
        capabilities: {
          browser_name: browser_name
        })
    ).driver
  end

  def config_ru_path
    File.expand_path(File.join(__FILE__, '../dummy_app/config.ru'))
  end
end

World(ContinousIntegration)
