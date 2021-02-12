class PagesController < ApplicationController
  skip_before_action :authenticate_member!

  def home
  end

  def viewer
    @stream = Stream.find_by(:short_url_key, params[:short_url_key])
    render 'viewer', layout: 'simple'
  end
end
