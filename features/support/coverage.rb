if ENV['TRAVIS']
  require 'codeclimate-test-reporter'
  require 'simplecov'
  require 'coveralls'
  Coveralls.wear!

  formatters = [SimpleCov::Formatter::HTMLFormatter]
  formatters << Coveralls::SimpleCov::Formatter
  if ENV['CODECLIMATE_REPO_TOKEN']
    formatters << CodeClimate::TestReporter::Formatter
  end

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[*formatters]
  SimpleCov.start do
    add_filter '/features/'
    add_group 'Libraries', 'lib'
  end
end
