require 'sinatra/base'

# Rack application to work with RackNonCache middleware
class DummyApp < Sinatra::Base
  get '/' do
    haml :index
  end
end
