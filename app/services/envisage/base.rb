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
      api_call("get")
    end

    def post
      api_call("post")
    end

    private

    def resource_path
      raise NotImplementedError
    end

    def api_call(action_method)
      uri = URI(File.join(envisage_base_url, resource_path))
      uri.query = URI.encode_www_form(params)

      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
        request = nil
        if action_method == 'post'
          request = Net::HTTP::Post.new uri
          request.set_form_data(params)
        else
          request = Net::HTTP::Get.new uri
        end
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



