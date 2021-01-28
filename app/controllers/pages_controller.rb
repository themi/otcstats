class PagesController < ApplicationController
  skip_before_action :authenticate_member!

  def home
  end

  def viewer
    @signed_token = params[:signed_token]
  end
end
