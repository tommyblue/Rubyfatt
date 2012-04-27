class DatepickerInput < SimpleForm::Inputs::Base
  def input
    "#{@builder.text_field(attribute_name, input_html_options.merge(datepicker_options(object.send(attribute_name))))}".html_safe
  end
  
  def datepicker_options(value = nil)
    datepicker_options = {:class => 'input-small datepicker string', :value => value.nil?? nil : value.strftime("%d/%m/%Y")}
  end
end