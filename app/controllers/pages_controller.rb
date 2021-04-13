class PagesController < ApplicationController
  skip_before_action :authenticate_member!

  def home
  end

  def viewer
    @stream = Stream.find(params[:short_url_key])
    render 'viewer', layout: 'simple'
  end

  def signed
    @signed_url = SignedUrl.find_by(short_path: params[:short_path])

    if @signed_url.nil?
      redirect_to root_path, alert: "Invalid link!"
      return
    elsif Time.current > (@signed_url.created_at + @signed_url.expires_in)
      redirect_to root_path, alert: "That link has expired"
      return
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

end
