module ApplicationHelper
  def notice_alert_color(type)
    case type
    when :notice
      "info"
    when :alert
      "danger"
    else
      "secondary"
    end
  end


  def render_fact_titles(field_titles)
    if field_titles
      tag.ul do
        field_titles.split("|").map { |n| tag.li(n) }.join("").html_safe
      end
    end
  end


  def graph_action_buttons(record)
    disabled = record.restricted? && current_member.member?

    link_to_stats = button_to("#", class: "btn btn-success btn-sm m-1", disabled: disabled, data: { toggle: "tooltip", placement: "top" }, title: "Add my stats") do
      tag.i(class: "bi bi-graph-up")
    end

    if current_member.member?
      link_to_stats
    else
      link_to_stats + table_action_buttons(record)
    end
  end

  def table_action_buttons(record)
    disabled = current_member.member?

    url = "/#{record.class.name.tableize}/:#{record.id}"

    button_to(url, class: "btn btn-success btn-sm m-1", disabled: disabled, data: { toggle: "tooltip", placement: "top" }, title: "Display this record") do
      tag.i(class: "bi bi-search")
    end + \
    button_to("#{url}/edit", class: "btn btn-primary btn-sm m-1", disabled: disabled, data: { toggle: "tooltip", placement: "top" }, title: "Edit this record") do
      tag.i(class: "bi bi-pencil-fill")
    end + \
    button_to(url, class: "btn btn-danger btn-sm m-1", disabled: disabled, method: :delete, data: { confirm: 'Are you sure?' }, data: { toggle: "tooltip", placement: "top" }, title: "Delete this record") do
      tag.i(class: "bi bi-trash-fill")
    end
  end

  def create_new_action_button(model_name, icon_class_name="plus")
    unless current_member.member?
      url = "/#{model_name.tableize}/new"

      button_to url, class: "btn btn-info btn-sm m-1", disabled: disabled, data: { toggle: "tooltip", placement: "top" }, title: "Add a new #{model_name}" do
        tag.i(class: "bi bi-#{icon_class_name}") + " " + model_name
      end
    end
  end


end
