class ApplicationController < ActionController::Base
  before_action :authenticate_member!

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || graphs_path
  end
end
