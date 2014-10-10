require "hashie/mash"

require "ebay/api_error"

module Ebay
  module ApiHelpers

    private

    def token_credentials(token)
      {
        requester_credentials: {
          '@env:mustUnderstand' => 0,
          content!: {
            'eBayAuthToken' => token
          }
        }
      }
    end

    def keyset_credentials
      {
        requester_credentials: {
          '@env:mustUnderstand' => 0,
          content!: {
            credentials: {
              app_id:    Ebay::Api.app_id,
              dev_id:    Ebay::Api.dev_id,
              auth_cert: Ebay::Api.cert
            }
          }
        }
      }
    end

    def extract_values(api_response)
      response_hash = api_response.body.values.first
      normalize_values!(response_hash)
      response = Hashie::Mash.new(response_hash).freeze
      unless ['Success', 'Warning'].include? response.ack
        raise ApiError, response.errors
      end
      response
    end

    def normalize_values!(hash)
      hash.each do |key, value|
        case value
        when /^\d+$/
          hash[key] = value.to_i
        when /^\d*\.\d+$/
          hash[key] = value.to_f
        when Hash
          if key =~ /_array$/
            array = value.values.first
            array = [array] unless array.is_a?(Array)
            array.each {|item| normalize_values!(item) if item.is_a?(Hash)}
            hash[key] = array
          else
            normalize_values!(value)
          end
        end
      end
    end

  end
end
