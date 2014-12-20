require 'sinatra/base'
require 'sinatra/json'
require 'data_mapper'

# If you want the logs displayed you have to do this before the call to setup
DataMapper::Logger.new($stdout, :warn)

# A Sqlite3 connection:
DataMapper.setup(:default, 'sqlite:data.db')

class Todo
  include DataMapper::Resource

  property :id,         Serial
  property :text,       Text
  # property :created_at, DateTime, :default => lambda { |r,p| Time.now }
  property :done,       Boolean, default: false
end

DataMapper.finalize
DataMapper.auto_upgrade!

# Rack application to work with RackNonCache middleware
class DummyApp < Sinatra::Base
  helpers Sinatra::JSON
  helpers do
    def json_data
      JSON.parse request.body.read
    end
  end

  before '/todos*' do
    content_type 'application/json'
  end

  get '/index' do
    @todos = Todo.all
    erb :index
  end

  get '/details' do
    erb :details
  end

  get '/todos' do
    session[:todos].t
    Todo.all.to_json
  end

  get '/todos/:id' do
    todo = Todo.get(params[:id])
    todo.to_json
  end

  put '/todos/:id' do
    todo = Todo.get(params[:id])
    todo.update(json_data)
    todo.to_json
  end

  post '/todos' do
    todo = Todo.create(json_data)
    todo.to_json
  end

  delete '/todos/:id' do
    todo = Todo.get(params[:id])
    todo.destroy
  end
end
