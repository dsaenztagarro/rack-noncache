require 'sinatra/base'
require "sinatra/json"
require 'haml'

# Rack application to work with RackNonCache middleware
class DummyApp < Sinatra::Base
  helpers Sinatra::JSON

  before '/api/*' do
    content_type 'application/json'
  end

  get '/' do
    @todos = session[:todos] || []
    haml :index
  end

  get '/api/todos' do
    session[:todos].t
    Todo.all.to_json
  end

  get '/api/todos/:id' do
    todo = Todo.get(params[:id])
    todo.to_json
  end

  put '/api/todos/:id' do
    todo = Todo.get(params[:id])
    todo.update(json_data)
    todo.to_json
  end

  post '/api/todos' do
    todo = Todo.create(json_data)
    todo.to_json
  end

  delete '/api/todos/:id' do
    todo = Todo.get(params[:id])
    todo.destroy
  end
end
