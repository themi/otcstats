class AutocompleterInput < SimpleForm::Inputs::TextInput
  #enable :placeholder, :maxlength

  def input(wrapper_options = nil)
    out = ActiveSupport::SafeBuffer.new

    new_html_options = merge_wrapper_options(prepare_html_options, wrapper_options)

    out << @builder.text_field(attribute_name, new_html_options)
    out
  end

  def prepare_html_options
    new_options = {}

    new_options[:class] = [input_html_options[:class], options[:class]].compact
    new_options[:value] = options[:value] unless options[:value].nil?

    new_options["data-provider"] = "autocompleter"
    new_options["data-url"] = "/#{options[:model].tableize}"
    new_options["data-fieldname"] = options[:fieldname]

    input_html_options.merge new_options
  end
end

