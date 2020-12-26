module Envisage
  class Base

    attr_reader :params, :response_data

    def initialize(*)
    end

    def error?
      !(response_data.is_a?(Net::HTTPSuccess))
    end

    def response_body
      JSON.parse(response_data.body)
    end

    def get
      api_get
    end

    private

    def resource_path
      raise NotImplementedError
    end

    def api_get
      uri = URI(File.join(envisage_base_url, resource_path))
      uri.query = URI.encode_www_form(params) if params

      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
        request = Net::HTTP::Get.new uri
        request["Content-Type"] = "application/json"
        request["Accept"] = "application/json"
        request["api-email"] = "#{envisage_api_email}"
        request["api-key"] = envisage_api_key
        @response_data = http.request(request)
      end
    end

    def envisage_base_url
      ENV.fetch("ENVISAGE_BASE_URL")
    end

    def envisage_api_email
      ENV.fetch("ENVISAGE_API_EMAIL")
    end

    def envisage_api_key
      ENV.fetch("ENVISAGE_API_KEY")
    end

 end
end



