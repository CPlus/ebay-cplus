require 'yaml'
require 'erb'

module Ebay
  module Configuration

    attr_accessor :wsdl, :schema_version, :sandbox_uri, :production_uri,
                  :site_id, :app_id, :dev_id, :cert, :use_sandbox,
                  :ru_name, :ru_name_sandbox_url, :ru_name_production_url

    def self.extended(base)
      base.configure_defaults
    end

    def configure_defaults
      self.schema_version = 873
      self.site_id = 3 # default to UK
      self.sandbox_uri = "https://api.sandbox.ebay.com/wsapi"
      self.production_uri = "https://api.ebay.com/wsapi"
      self.ru_name_sandbox_url = "https://signin.sandbox.ebay.com/"
      self.ru_name_production_url = "https://signin.ebay.com/"
    end

    def configure(settings)
      settings.each do |key, value|
        setter = "#{key}="
        send(setter, value) if respond_to?(setter)
      end
    end

    def configure_from_yaml(path, env=nil)
      settings = load_yaml_configuration(path, env)
      configure(settings)
    end

    def namespace
      'urn:ebay:apis:eBLBaseComponents'
    end

    def using_sandbox?
      use_sandbox
    end

    def uri
      using_sandbox? ? sandbox_uri : production_uri
    end

    def ru_url(session_id)
      ru_name_url + "ws/eBayISAPI.dll?SignIn&RuName=#{self.ru_name}&SessID=#{session_id}"
    end

    def ru_name_url
      using_sandbox? ? ru_name_sandbox_url : ru_name_production_url
    end

    private

    def load_yaml_configuration(path, env)
      hash_content = YAML.load(ERB.new(File.read(path)).result)
      env ? hash_content[env] : hash_content
    end

  end
end
