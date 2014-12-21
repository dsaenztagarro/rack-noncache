module Rack
  module NonCache
    class Http10Filter
      def self.apply(headers)
        headers['Cache-Control'] =
          'max-stale=0, post-check=0, pre-check=0, ' \
          'no-cache=\"Set-Cookie, Set-Cookie2\"'
      end
    end

    class Http11Filter
      def self.apply(headers)
        headers['Cache-Control'] += 'no-cache, max-age=0, must-revalidate, ' \
                                   'no-store, private'
        headers['Pragma'] = 'no-cache, private'
      end
    end

    class ProxyFilter
      def self.apply(headers)
        headers['HTTP_EXPIRES'] = Time.now.httpdate
      end
    end

    class SecurityFilter
      def self.apply(headers)

        # When you type in your bank's website, do you enter mybank.example.com
        # or do you enter https://mybank.example.com? If you omit the https
        # protocol, you are potentially vulnerable to Man in the Middle
        # attacks. Even if the website performs a redirect to
        # https://mybank.example.com a malicious user could intercept the
        # initial HTTP request and manipulate the response (i.e. redirect to
        # https://mibank.example.com and steal their credentials).
        #
        # Many users omit the https protocol and this is why HTTP Strict
        # Transport Security (HSTS) was created. Once mybank.example.com is
        # added as a HSTS host, a browser can know ahead of time that any
        # request to mybank.example.com should be interpreted as
        # https://mybank.example.com. This greatly reduces the possibility of a
        # Man in the Middle attack occurring.

        headers['Strict-Transport-Security'] = 'max-age=31536000; includeSubDomains'

        # The problem with content sniffing is that this allowed malicious
        # users to use polyglots (i.e. a file that is valid as multiple content
        # types) to execute XSS attacks. For example, some sites may allow
        # users to submit a valid postscript document to a website and view it.
        # A malicious user might create a postscript document that is also a
        # valid JavaScript file and execute a XSS attack with it.

        headers['X-Content-Type-Options'] = 'nosniff'

        # Some browsers have built in support for filtering out reflected XSS
        # attacks. This is by no means full proof, but does assist in XSS
        # protection.
        # The filtering is typically enabled by default, so adding the header
        # typically just ensures it is enabled and instructs the browser what
        # to do when a XSS attack is detected. For example, the filter might
        # try to change the content in the least invasive way to still render
        # everything. At times, this type of replacement can become a XSS
        # vulnerability in itself. Instead, it is best to block the content
        # rather than attempt to fix it.

        headers['S-Protection'] = '1; mode=block'
      end
    end

    class DeprecatedFilter
      def self.apply(headers)
        headers['HTTP_KEEP_ALIVE'] = 'timeout=3, max=993'
      end
    end
  end
end
