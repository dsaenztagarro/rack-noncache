require "rack"
require "rack/noncache/version"
require "rack/noncache/engine"

module Rack
  module NonCache

    def self.new(backend, options={}, &b)
      Engine.new(backend, options, &b)
    end

  end
end
