module Ebay
  module ApiMethods

    def get_session_id
      response = @client.call :get_session_id,
        soap_header: keyset_credentials,
        message: { ru_name: self.class.ru_name }
      extract_values response
    end

    def fetch_token(session_id)
      response = @client.call :fetch_token,
        soap_header: keyset_credentials,
        message: { 'SessionID' => session_id }
      extract_values response
    end

    def get_orders(options={})
      response = @client.call :get_orders, message: options
      extract_values response
    end

  end
end
