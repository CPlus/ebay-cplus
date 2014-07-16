# Ebay

Lean eBay Trading API client. It implements only a few methods of the API, the ones that we need for CollectPlus.

## Installation

Add this line to your application's Gemfile:

    gem 'ebay', git: 'https://github.com/CPlus/ebay-cplus'

## Usage

``` ruby
require 'ebay'

Ebay::Api.dev_id = 'your-ebay-dev-id'
Ebay::Api.app_id = 'your-ebay-app-id'
Ebay::Api.cert = 'your-ebay-auth-cert'
Ebay::Api.use_sandbox = true
Ebay::Api.ru_name = "your-ru-name"

# wsdl is optional, and only with a local copy and in development
# otherwise it might slow down the request/response cycle
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
