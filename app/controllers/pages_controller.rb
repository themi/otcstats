class PagesController < ApplicationController
  skip_before_action :authenticate_member!

  def home
  end
end
