module Mercadolibre
  class Api
    attr_accessor :access_token

    def initialize(args={})
      @credentials  = args[:credentials]

      @app_key      = args[:app_key]
      @app_secret   = args[:app_secret]
      @callback_url = args[:callback_url]
      @access_token = args[:access_token] || @credentials[:token]

      @site         = args[:site        ] || 'MLA'
      @endpoint_url = args[:endpoint_url] || "https://api.mercadolibre.com"
      @auth_url     = args[:auth_url    ] || "http://auth.mercadolibre.com/authorization"
    end

    include Mercadolibre::Core::Auth
    include Mercadolibre::Core::CategoriesAndListings
    include Mercadolibre::Core::ItemsAndSearches
    include Mercadolibre::Core::LocationsAndCurrencies
    include Mercadolibre::Core::OrderManagement
    include Mercadolibre::Core::Questions
    include Mercadolibre::Core::Users

    private

    def get_request(action, params={}, headers={})
      begin
        parse_response(RestClient.get("#{@endpoint_url}#{action}", {params: params}.merge(headers)))
      rescue => e
        parse_response(e.response)
      end
    end

    def post_request(action, params={}, headers={})
      begin
        parse_response(RestClient.post("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response(e.response)
      end
    end

    def put_request(action, params={}, headers={})
      begin
        parse_response(RestClient.put("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response(e.response)
      end
    end

    def patch_request(action, params={}, headers={})
      begin
        parse_response(RestClient.patch("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response(e.response)
      end
    end

    def head_request(action, params={})
      begin
        parse_response(RestClient.head("#{@endpoint_url}#{action}", params))
      rescue => e
        parse_response(e.response)
      end
    end

    def delete_request(action, params={})
      begin
        parse_response(RestClient.delete("#{@endpoint_url}#{action}", params))
      rescue => e
        parse_response(e.response)
      end
    end

    def parse_response(response)
      {
        headers: response.headers,
        body: (JSON.parse(response.body) rescue response.body),
        status_code: response.code
      }
    end
  end
end
