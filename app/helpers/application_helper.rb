module ApplicationHelper
  def notice_alert_color(type)
    case type
    when :notice
      "success"
    when :alert
      "danger"
    else
      "info"
    end
  end

  def table_action_buttons(record, vars, actions=[], commands="ed")
    url = "/#{record.class.name.tableize}/#{record.id}"

    if commands.include?("s")
      actions << button_to(url, class: "btn btn-success btn-sm m-1", method: :get, data: { toggle: "tooltip", placement: "top" }, title: "Display this record") do
        concat tag.i(class: "bi bi-search")
        concat hidden_field_tag(vars[0].to_sym, vars[1]) unless vars.empty?
      end
    end

    if commands.include?("e")
      actions << button_to("#{url}/edit", class: "btn btn-primary btn-sm m-1", method: :get, data: { toggle: "tooltip", placement: "top" }, title: "Edit this record") do
        concat tag.i(class: "bi bi-pencil-fill")
        concat hidden_field_tag(vars[0].to_sym, vars[1]) unless vars.empty?
      end
    end

    if commands.include?("d")
      actions << button_to(url, class: "btn btn-danger btn-sm m-1", method: :delete, data: { confirm: 'Are you sure?', toggle: "tooltip", placement: "top" }, title: "Delete this record") do
        concat tag.i(class: "bi bi-trash-fill")
        concat hidden_field_tag(vars[0].to_sym, vars[1]) unless vars.empty?
      end
    end

    actions.join().html_safe
  end

  def create_new_action_button(model_name, icon_class_name="plus", vars=[])
    url = "/#{model_name.tableize}/new"

    button_to url, class: "btn btn-success mb-1", method: :get, data: { toggle: "tooltip", placement: "top" }, title: "Add a new #{model_name}" do
      concat tag.i(class: "bi bi-#{icon_class_name}") + " " + model_name
      concat hidden_field_tag(vars[0].to_sym, vars[1]) unless vars.empty?
    end
  end

  def render_statistic_value(stat)
    number_with_precision(stat.value, precision: 0) + "#{stat.currency}"
  end

end
