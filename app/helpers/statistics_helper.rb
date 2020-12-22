module StatisticsHelper

  def render_statistic(stat)
    "#{stat}: #{stat.value}"
  end

end
