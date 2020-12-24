class AutocompleteInput < SimpleForm::Inputs::TextInput
  enable :placeholder, :maxlength

  def input(wrapper_options = nil)
    out = ActiveSupport::SafeBuffer.new

    new_html_options = merge_wrapper_options(prepare_html_options, wrapper_options)

    out << @builder.text_field(attribute_name, new_html_options)
    out
  end

  def prepare_html_options
    new_options = {}

    new_options[:class] = [input_html_options[:class], options[:class]].compact

    new_options["data-toggle"] ||= "autocomplete"
    new_options["data-url"] = "/#{options[:model].tableize}"
    new_options["data-model"] = options[:model].classify
    new_options["data-method"] = options[:method]

    new_options[:value] = options[:value] unless options[:value].nil?
    new_options[:value_text] = options[:value_text] unless options[:value_text].nil?

    input_html_options.merge new_options
  end
end

