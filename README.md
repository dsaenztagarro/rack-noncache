[![Gem Version](https://badge.fury.io/rb/rack-noncache.svg)](http://badge.fury.io/rb/rack-noncache)
[![Build Status](https://travis-ci.org/dsaenztagarro/rack-noncache.png)](https://travis-ci.org/dsaenztagarro/rack-noncache)
[![Code Climate](https://codeclimate.com/github/dsaenztagarro/rack-noncache/badges/gpa.svg)](https://codeclimate.com/github/dsaenztagarro/rack-noncache)
[![Coverage Status](https://coveralls.io/repos/dsaenztagarro/rack-noncache/badge.png?branch=master)](https://coveralls.io/r/dsaenztagarro/rack-noncache?branch=master)
[![Dependency Status](https://gemnasium.com/dsaenztagarro/rack-noncache.svg)](https://gemnasium.com/dsaenztagarro/rack-noncache)

# Rack::NonCache

Rack::NonCache is a rack middleware that disables HTTP browser caching.

## Installation

From Gem:

    $ sudo gem install rack-noncache

With a local working copy:

    $ git clone git://github.com/dsaenztagarro/rack-noncache.git
    $ rake package && sudo rake install

## Basic Usage

Rack::NonCache is implemented as a piece of Rack middleware and can be used with
any Rack-based application. If your application includes a rackup (`.ru`) file
or uses Rack::Builder to construct the application pipeline, simply require
and use as follows:

```ruby
require 'rack/noncache'

use Rack::NonCache,
    :whitelist => ['/path/to/non/caching/url', ...,
                   Regexp.new(/^\/path\/to\/non\/caching\/url/)]

run app
```

Assuming you've designed your backend application to take advantage of HTTP's
caching features, no further code or configuration is required for basic
caching.

## Using with Rails

Add this to your `config/environment.rb`:

```ruby
# White list approach (option 1)
config.middleware.use Rack::NonCache,
    :whitelist => ['/path/to/non/caching/url', ...,
                   Regexp.new(/^\/path\/to\/non\/caching\/url/)]

# Black list approach (option 2)

config.middleware.use Rack::NonCache,
    :blacklist => ['/path/to/non/caching/url', ...,
                   Regexp.new(/^\/path\/to\/non\/caching\/url/)],
```

You should now see `Rack::NonCache` listed in the middleware pipeline: 
`rake middleware`

## Contributing

1. Fork it ( https://github.com/dsaenztagarro/rack-noncache/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
