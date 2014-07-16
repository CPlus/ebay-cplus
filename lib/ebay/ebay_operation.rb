module Ebay
  module EbayOperation

    # Constructs the appropriate routing url for the Ebay API
    # see: http://developer.ebay.com/Devzone/xml/docs/Concepts/MakingACall.html#SOAPURLParameters
    def endpoint
      base_url = @wsdl.endpoint.to_s

      params = {
        version: Ebay::Api.schema_version,
        siteid: Ebay::Api.site_id,
        callname: camelcase(@name),
        Routing: 'new'
      }
      if @name == :get_account
        params[:appid] = Ebay::Api.app_id
      end

      base_url += base_url.index('?') ? '&' : '?'
      base_url + URI.encode_www_form(params)
    end

    # Adds required standard input field Version and sets the correct
    # message tag name to support operation without a wsdl
    def build(locals={}, &block)
      set_locals(locals, block)
      @locals[:message][:version] = Ebay::Api.schema_version
      @locals.message_tag camelcase(@name.to_s =~ /_request$/ ? @name : "#{@name}_request")
      Savon::Builder.new(@name, @wsdl, @globals, @locals)
    end

    private

    def camelcase(string)
      string.to_s.capitalize.gsub(/_+(id(?=_|$)|[a-z])/) {$1.upcase}
    end

  end
end
