class ApplicationController < ActionController::Base
  before_action :authenticate_member!
  before_action :browser_object

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || graphs_path
  end

  def browser_object
    @browser_object ||= CheckMobile.new(request)
  end
  helper_method :browser_object
end
