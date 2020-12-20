require "browser"

class CheckMobile
  attr_reader :browser
  def initialize(request)
    request.user_agent
    @browser = Browser.new(request.user_agent)
  end
  def is_mobile?
    browser.device.mobile?
  end
end
