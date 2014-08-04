module BootstrapFormHelper

  def bootstrap_form_for(object, options={}, &block)
    options[:html] ||= {}
    options[:html][:role] = "form"
    options[:builder] ||= BootstrapControlHelper::BootstrapForm

    layout = case options[:layout]
               when :inline
                 "form-inline"
               when :horizontal
                 "form-horizontal"
             end

    if layout
      options[:html][:class] = [options[:html][:class], layout].compact.join(" ")
    end
    disabled(options) do
      form_for(object, options, &block)
    end
  end

  def disabled(options={})
    options[:disabled] ? content_tag(:fieldset, "", disabled: true) { yield } : yield
  end
end