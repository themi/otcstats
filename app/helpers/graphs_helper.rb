module GraphsHelper

  def browser_object
    @browser_object ||= CheckMobile.new(request)
  end

end
