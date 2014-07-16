module Ebay
  class ApiError < StandardError

    attr_reader :response

    def initialize(response)
      @response = response
      super(@response.short_message)
    end

  end
end
