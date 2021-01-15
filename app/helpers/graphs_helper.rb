module GraphsHelper

  def browser_object
    @browser_object ||= CheckMobile.new(request)
  end

  def stats_total_for(eow, graph)
    if current_member.member?
      Statistic.my_total_stats(eow, graph.id, current_member.id)
    else
      Statistic.total_stats(eow, graph.id)
    end
  end

  def restricted_graph?(record)
    record.restricted? && current_member.member?
  end

  def graph_action_buttons(record, commands="ed")
    disabled = restricted_graph?(record)

    link_to_stats = []
    link_to_stats << button_to(new_statistic_path, method: :get, class: "btn btn-success btn-sm m-1", disabled: disabled, data: { toggle: "tooltip", placement: "top" }, title: "Add my stats") do
      concat tag.i(class: "bi bi-graph-up")
      concat hidden_field_tag('graph_id', record.id)
    end

    link_to_stats << button_to(statistics_path, method: :get, class: "btn btn-primary btn-sm m-1", disabled: disabled, data: { toggle: "tooltip", placement: "top" }, title: "View my stats") do
      concat tag.i(class: "bi bi-search")
      concat hidden_field_tag('graph_id', record.id)
    end

    link_to_stats.join().html_safe
  end

end
