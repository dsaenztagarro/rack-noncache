require_relative 'filters'

module Rack
  module NonCache
    class Engine
      attr_accessor :whitelist, :blacklist

      def initialize(backend, options)
        @backend = backend
        @whitelist = options[:whitelist]
        @blacklist = options[:blacklist]
        yield self if block_given?
      end

      def call(env)
        # execute the request using our backend
        status, headers, response = @backend.call(env)

        uri = env['REQUEST_URI']
        filters.each { |filter| filter.apply(headers) } if target_path? uri
        [status, headers, response]
      end

      private

      def filters
        [Http10Filter, Http11Filter, ProxyFilter, SecurityFilter,
         DeprecatedFilter]
      end

      def target_path?(uri)
        if @whitelist
          return match(@whitelist, uri)
        elsif @blacklist
          return !match(@blacklist, uri)
        else
          false
        end
      end

      def match(list, uri)
        list.index do |path|
          (path.class.eql?(String) && path.eql?(uri)) ||
            (path.class.eql?(Regexp) && path.match(uri))
        end
      end
    end
  end
end
