module StatisticsHelper

  def render_statistic(stat)
    if stat
      "#{stat}: #{stat.value}"
    else
      flash.notice || "Statistic successfully updated"
    end
  end

  def render_column_label(form, title)
    if title == "ea"
      form.input :value, label: "Enter each", input_html: { value: 1, readonly: true }
    else
      form.input :value, label: title
    end
  end

  def render_column_input(form, title, index)
    case title
    when /OTC Member/
      form.input "fact_column_#{index+1}".to_sym, label: title, as: :autocompleter, model: "Member", fieldname: "full_name", scope: "admin"
    when "Org"
      form.input "fact_column_#{index+1}".to_sym, label: title, collection: Organisation.select_list
    else
      form.input "fact_column_#{index+1}".to_sym, label: title
    end

  end

end
