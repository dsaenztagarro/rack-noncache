require 'capybara_selenium'

# Helpers for accessing configuration option
module ContinousIntegration
  def driver_for(browser_name)
    @configurator = CapybaraSelenium::Configurator.new
    configure_rack_app_server
    configure_selenium_server(browser_name)
    @configurator.apply
  end

  def configure_rack_app_server
    @configurator.rack_app_server.configure do |config|
      config.host = ENV['CI_APP_SERVER_HOST'] || 'localhost'
      config.port = ENV['CI_APP_SERVER_PORT'] || 8080
      config.config_ru_path  = File.expand_path(
        File.join(__FILE__, '../web_app/config.ru'))
    end
  end

  def configure_selenium_server(browser_name)
    @configurator.remote_selenium_server.configure do |config|
      config.server_url = ENV['CI_SELENIUM_SERVER_URL'] ||
        'http://127.0.0.1:4444/wd/hub'
      config.capabilities = { browser_name: browser_name }
    end
  end
end

World(ContinousIntegration)
