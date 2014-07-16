# Ebay

Lean eBay Trading API client. It implements only a few methods of the API, the ones that we need for CollectPlus.

## Installation

Add this line to your application's Gemfile:

    gem 'ebay', git: 'https://github.com/CPlus/ebay-cplus'

## Configuration

In Rails just create a file at `config/ebay.yml` with the following
content:

``` yaml
development: &dev
  dev_id:  ...
  app_id:  ...
  cert:    ...
  ru_name: ...
  use_sandbox: yes

staging:
  <<: *dev

production: &prod
  dev_id:  ...
  app_id:  ...
  cert:    ...
  ru_name: ...
  use_sandbox: no
```

Also, you might want to download [eBay's latest
WSDL](http://developer.ebay.com/webservices/latest/eBaySvc.wsdl) and
save it to `config/eBaySvc.wsdl` during development. This file will also
be picked up automatically in a Rails application.  It's not recommended
to do this in production as it can degrade performance of API requests.

When not using the gem within a Rails app, or if you want to configure
it manually, you can use any of the following methods:

``` ruby
# 1. Configure from a YAML file
# env is only needed if YAML file contains configuration for multiple environments
Ebay::Api.configure_from_yaml(path, env) 

# 2. Configure with a hash of options
Ebay::Api.configure dev_id: '...', app_id: '...', cert: '...',
                    ru_name: '...', use_sandbox: true

# 3. Set everything separately
Ebay::Api.dev_id = 'your-ebay-dev-id'
Ebay::Api.app_id = 'your-ebay-app-id'
Ebay::Api.cert = 'your-ebay-auth-cert'
Ebay::Api.ru_name = "your-ru-name"
Ebay::Api.use_sandbox = true
```

## Usage

``` ruby
# wsdl is optional, and recommended only with a local copy and during
# development, otherwise it might slow down the request/response cycle
client = Ebay::Api.new wsdl: './eBaySvc.wsdl'

sid = client.get_session_id
Ebay::Api.ru_url(sid.session_id) # => "https://signin.sandbox.ebay.com/ws/eBayISAPI.dll?...
# visit this url and authorize the application
token = client.fetch_token(sid.session_id)

client = Ebay::Api.new auth_token: token.ebay_auth_token

client.get_orders number_of_days: 7
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
