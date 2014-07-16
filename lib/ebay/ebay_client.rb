require "ebay/ebay_operation"

module Ebay
  module EbayClient

    # Creates a new Savon::Operation and immediately extends it with
    # our implementations necessary for the Ebay API
    def operation(operation_name)
      Savon::Operation.create(operation_name, @wsdl, @globals).tap do |op|
        op.extend EbayOperation
      end
    end

  end
end
