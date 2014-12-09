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

        if target_path? env['REQUEST_URI']

          headers['HTTP_CACHE_CONTROL'] =
            'no-cache, max-age=0, must-revalidate, no-store, private, '

          # Set standard HTTP/1.0 no-cache header.
          headers['HTTP_CACHE_CONTROL'] +=
            'max-stale=0, post-check=0, pre-check=0, ' +
            'no-cache=\"Set-Cookie, Set-Cookie2\"'

          # Set standard HTTP/1.1 no-cache header.
          headers['HTTP_PRAGMA'] = 'no-cache'

          # Set to expire far in the past. Prevents caching at the proxy server
          headers['HTTP_EXPIRES'] = Time.now.httpdate

          # Deprecated header
          headers['HTTP_KEEP_ALIVE'] = 'timeout=3, max=993'

          headers['X-Content-Type-Options'] = 'nosniff'
        end

        [status, headers, response]
      end

      private

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
