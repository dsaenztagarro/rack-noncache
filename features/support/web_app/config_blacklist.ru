require 'rack'

require_relative 'application'
require_relative '../../../lib/rack/noncache'

app = Rack::Builder.new do
  use Rack::NonCache, blacklist: []
  map '/' do
    run DummyApp
  end
end

run app
