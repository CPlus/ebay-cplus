module Ebay
  class Railtie < Rails::Railtie
    initializer "ebay.configure_api_settings" do
      path = Rails.root.join("config/ebay.yml")
      Ebay::Api.configure_from_yaml(path, Rails.env) if path.exist?
    end
  end
end
