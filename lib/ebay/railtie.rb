module Ebay
  class Railtie < Rails::Railtie
    initializer "ebay.configure_api_settings" do
      path = Rails.root.join("config/ebay.yml")
      Ebay::Api.configure_from_yaml(path, Rails.env) if path.exist?

      wsdl_path = Rails.root.join("config/eBaySvc.wsdl")
      Ebay::Api.wsdl = wsdl_path if wsdl_path.exist?
    end
  end
end
