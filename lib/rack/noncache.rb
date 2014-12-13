require 'rack'
require 'rack/noncache/version'
require 'rack/noncache/engine'

module Rack
  module NonCache
    def self.new(backend, opts = {}, &b)
      Engine.new(backend, opts, &b)
    end
  end
end
