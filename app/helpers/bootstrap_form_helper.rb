module BootstrapFormHelper

  def bootstrap_form_for(object, options={}, &block)
    #options.reverse_merge!({builder: BootstrapBuilderHelper::BootstrapBuilder::BootstrapControlHelper})
    options.reverse_merge!({builder: BootstrapControlHelper::BootstrapForm})

    layout = case options[:layout]
               when :inline
                 "form-inline"
               when :horizontal
                 "form-horizontal"
             end

    if layout
      options[:html] ||= {}
      options[:html][:class] = [options[:html][:class], layout].compact.join(" ")
    end

    form_for(object, options, &block)
  end
end