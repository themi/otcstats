class PostFeedbackSurvey

  attr_reader :params, :response_data

  def initialize(params)
    @params = params
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

    uri = URI(base_url)
    uri.query = URI.encode_www_form(params)

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
      request = nil
      if action_method == 'post'
        request = Net::HTTP::Post.new uri
        request.set_form_data(params)
      else
        request = Net::HTTP::Get.new uri
      end
      request["Content-Type"] = "application/x-www-form-urlencoded"
      @response_data = http.request(request)
    end
  end

  def base_url
    ENV.fetch("GOOGLE_SCRIPT_FEEDBACK_URL")
  end
end
