require 'capybara_selenium'
require_relative 'coverage'

Dir[File.join(__FILE__, '../../lib/**/*.rb')].each { |f| require f }

# Helpers for continous integration
module TestSettings
  APP_SERVER_HOST = ENV['CI_APP_SERVER_HOST'] || '127.0.0.1'
  APP_SERVER_PORT = ENV['CI_APP_SERVER_PORT'] || 8080
  SELENIUM_SERVER_URL = ENV['CI_SELENIUM_SERVER_URL'] ||
                        'http://127.0.0.1:4444/wd/hub'

  class << self
    # @param [Hash] opts The options for browser
    # @option opts [String] :browser_name The name of the browser. Valid values:
    #   firefox|chrome|internet explorer|safari|opera
    # @option opts [Integer] :version The version of the browser
    # @option opts [String] :strategy The strategy to configure the
    #   Rack::NonCache middleware
    def configure(opts = {})
      CapybaraSelenium.configure do |config|
        config.app_server.host = APP_SERVER_HOST
        config.app_server.port = APP_SERVER_PORT.to_i + port_counter
        config.app_server.config_ru_path = File.expand_path(File.join(
          __FILE__, "../web_app/config_#{opts[:strategy] || :whitelist}.ru"))

        config.selenium_server.server_url = SELENIUM_SERVER_URL
        config.selenium_server.capabilities = {
          'browser' => opts[:browser_name] || :firefox,
          'browser_name' => opts[:browser_name] || :firefox,
          'version' => opts[:version] || 'ANY',
          'tunnel-identifier' => ENV['TRAVIS_JOB_NUMBER'],
          'build' => ENV['TRAVIS_BUILD_NUMBER']
        }
      end
    end

    def port_counter
      @port_counter ||= 0
      @port_counter += 1
    end
  end
end

TestSettings.configure

World(TestSettings)
