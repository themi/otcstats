class PagesController < ApplicationController
  skip_before_action :authenticate_member!
  before_action :set_cache_headers, only: [:signed, :viewer]
  before_action :authenticate_signed_url, only: :signed

  def home
  end

  def viewer
    @stream = Stream.find(params[:short_url_key])
    render 'viewer', layout: 'simple'
  end

  def signed
    if @signed_url.nil?
      redirect_to root_path, alert: "Invalid link!" and return
    end

    if is_signed_url_expired?
      redirect_to root_path, alert: "That link has expired" and return
    end

    @stream = Stream.find(@signed_url.stream_id)
    @signed_url.update(used_at: Time.current)
    render 'signed', layout: 'simple'
  end

  def feedback
    @stream = Stream.find(params[:short_url_key])
    @survey = Survey.find(params[:short_url_key])
    render 'feedback', layout: 'simple'
  end

  def survey
    data_hash = survey_params.to_h
    if data_hash[:checkit].blank?
      if any_question_responses?(data_hash)
        survey = PostFeedbackSurvey.new(data_hash)
        survey.post
        @message = "Your feedback is much appreciated."
      else
        @message = "Feedback not sent."
      end
    else
      @message = "Data Error."
    end
    render 'survey', layout: 'simple'
  end

  private

  # Only allow a list of trusted parameters through.
  def survey_params
    params.require(:survey).permit(:video_title, :question1,:question2,:question3,:question4,:question5,:question6,:question7,:question8,:email,:phone,:name,:training,:processing,:checkit)
  end

  def any_question_responses?(data_hash)
    result = data_hash.map { |k,v| v if k.to_s.starts_with?("question") }
    result.reject { |c| c.blank? }.count > 0
  end

  def is_signed_url_expired?
    Time.current > (@signed_url.created_at + @signed_url.expires_in)
  end

  def authenticate_signed_url
    @signed_url = SignedUrl.find_by(short_path: params[:short_path])

    unless @signed_url.nil?
      if authenticate_with_http_basic { |u, p| @signed_url.check_valid_details(u, p) }
        # all good
      else
        request_http_basic_authentication
      end
    end

    true
  end

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
  end

end
