require 'capybara_selenium'
require_relative 'coverage'

Dir[File.join(__FILE__, '../../lib/**/*.rb')].each { |f| require f }

# Helpers for continous integration
module ContinousIntegration
  APP_SERVER_HOST = ENV['CI_APP_SERVER_HOST'] || 'localhost'
  APP_SERVER_PORT = ENV['CI_APP_SERVER_PORT'] || 8080
  SELENIUM_SERVER_URL = ENV['CI_SELENIUM_SERVER_URL'] ||
                        'http://127.0.0.1:4444/wd/hub'

  def ci_configure(browser_name)
    CapybaraSelenium::Configurator.new do |app_server, selenium_server|
      app_server.host = APP_SERVER_HOST
      app_server.port = APP_SERVER_PORT
      app_server.config_ru_path = File.expand_path(
        File.join(__FILE__, '../web_app/config.ru'))

      selenium_server.server_url = SELENIUM_SERVER_URL
      selenium_server.capabilities = {
        'browser_name' => browser_name,
        'tunnel-identifier' => ENV['TRAVIS_JOB_NUMBER']
      }
    end.configure
  end

  module_function :ci_configure
end

ContinousIntegration.ci_configure(:firefox)

World(ContinousIntegration)
