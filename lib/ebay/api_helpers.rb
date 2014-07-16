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
      response = Hashie::Mash.new(api_response.body.values.first).freeze
      if response.ack != 'Success'
        raise ApiError, response.errors
      end
      response
    end

  end
end
