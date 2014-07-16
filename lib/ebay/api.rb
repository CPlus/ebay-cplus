require "savon"

require "ebay/patches"

require "ebay/api_helpers"
require "ebay/api_methods"
require "ebay/configuration"
require "ebay/ebay_client"

module Ebay
  class Api

    extend Configuration

    include ApiHelpers
    include ApiMethods

    attr_reader :client

    def initialize(options={})
      setup_client_options(options)

      @client = Savon.client(@client_options)
      @client.extend EbayClient
    end

    private

    def setup_client_options(options)
      @client_options = options

      options[:wsdl]      ||= self.class.wsdl if self.class.wsdl
      options[:endpoint]  ||= self.class.uri
      options[:namespace] ||= self.class.namespace

      # these client options cannot be overwritten because the API
      # wrapper depends on these settings
      options.merge! convert_request_keys_to: :camelcase,
                     convert_response_tags_to: lambda { |tag|
                       tag.gsub('eBay', 'Ebay').snakecase.to_sym
                     },
                     namespace_identifier: nil

      if options.delete(:debug) || ENV['DEBUG']
        options.merge! log: true, pretty_print_xml: true
      end
    end

  end
end
