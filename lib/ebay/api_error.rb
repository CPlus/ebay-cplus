module Ebay
  class ApiError < StandardError

    attr_reader :response

    def initialize(response)
      @response = response
      error_message = if response.is_a? Array
                        @response.
                          map { |r| r.long_message || r.short_message }.
                          join "\n"
                      else
                        @response.long_message || @response.short_message
                      end
      super(error_message)
    end

  end
end
