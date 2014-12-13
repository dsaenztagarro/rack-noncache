require 'rack'

require_relative 'application'
require_relative '../../../lib/rack/noncache'

app = Rack::Builder.new do
  use Rack::NonCache, whitelist: [Regexp.new(/(.)*/)]
  map '/' do
    run DummyApp
  end
end

run app
