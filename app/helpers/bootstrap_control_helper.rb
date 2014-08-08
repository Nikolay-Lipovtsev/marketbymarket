

module BootstrapControlHelper
  class FormBuilder < ActionView::Helpers::FormBuilder

    COMMON_OPTIONS = [:layout, :label_class, :label_col, :label_offset, :label_text, :invisible_label, :required,
                      :control_class, :control_col, :control_offset, :placeholder, :popover, :error_disable,
                      :row_disable, :inline, :grid_system, :rows]

    LABEL_OPTIONS = [:layout, :label_class, :label_col, :label_text, :label_offset, :invisible_label, :grid_system]

    CONTROL_OPTIONS = [:class, :placeholder, :data, :html, :disabled, :rows]

    FIELD_HELPERS = %w{color_field date_field datetime_field datetime_local_field
                    email_field month_field number_field password_field phone_field
                    range_field search_field telephone_field text_area text_field time_field
                    url_field week_field}

    CHECK_BOX_AND_RADIO_HELPERS = %w{check_box radio}

    DATE_SELECT_HELPERS = %w{date_select time_select datetime_select}

    delegate :content_tag, :capture, :concat, to: :@template

    FIELD_HELPERS.each do |helper|
      define_method helper do |field, *args|
        options = args.detect{ |a| a.is_a?(Hash) } || {}
        options[:layout] = get_layout
        generate_form_group(helper, field, options) do
          options[:placeholder] ||= I18n.t("helpers.label.#{@object.class.to_s.downcase}.#{field}") if options[:placeholder] || options[:invisible_label]
          #super(field, options.slice(*CONTROL_OPTIONS)).concat(options[:layout].class)
        end
      end
    end

    CHECK_BOX_AND_RADIO_HELPERS

    def get_layout
      if @options[:layout]
        @options[:layout]
      elsif
        layout = /:layout=>:(inline|horizontal)/.match(@options.to_s)
        layout[1].to_sym if layout
      end
    end

    def generate_form_group_row(options = {})
      if options[:control_col] && !(options[:row_disable])
        content_tag(:div, "", class: "row") do
          content_tag(:div, "", class: options[:control_col]) { yield }
        end
      else
        yield
      end
      #options[:control_col] && !(options[:row_disable]) ? content_tag(:div, "", class: "row") { yield } : yield
    end

    def generate_form_group(helper, field, options={}, &block)
      options[:control_col] ||= default_date_col if helper == "date_field"
      generate_form_group_row(options.slice(:control_col)) do
        if options[:control_col] && options[:layout].nil?
          options[:class] = [options[:class], grid_system_class(options[:control_col])].compact.join(" ")
        end
        options[:class] = [options[:class], "form-group"].compact.join(" ")
        options[:class] = [options[:class], "has-error"].compact.join(" ") if has_error?(field, options)
        content_tag(:div, class: options[:class]) do
          generate_label(field, options.slice(*LABEL_OPTIONS)).concat(generate_control(options, &block))
        end
      end
    end

    def generate_label(field, options={})
      options[:class] = label_class(options)
      label(field, options[:label_text], options.slice(:class))
    end

    def label_class(options={})
      options[:label_class] = [options[:label_class], "sr-only"].compact.join(" ") if options[:invisible_label]
      options[:label_class] = [options[:label_class], "control-label"].compact.join(" ") if options[:layout] == :horizontal
      [label_col_class(options), options[:label_class]].compact.join(" ")
    end

    def label_col_class(options={})
      unless options[:label_col]
        if options[:layout] == :horizontal
          grid_system_class(default_horizontal_label_col)
        elsif options[:layout] == :inline
          "sr-only"
        end
      else
        grid_system_class(options[:label_col])
      end
    end

    def generate_control(options={}, &block)
      options[:class] = control_class(options)
      if options[:layout] == :horizontal
        content_tag(:div, class: control_col_class(options)) { yield }
      else
        yield
      end
    end

    def control_class(options={})
      ["form-control", options[:control_class]].compact.join(" ")
    end

    def control_col_class(options={})
      unless options[:control_col]
        grid_system_class(default_horizontal_control_col) if options[:layout] == :horizontal
      else
        grid_system_class(options[:control_col])
      end
    end

    def has_error?(field, options={})
      @object.respond_to?(:errors) && !(field.nil? || @object.errors[field].empty?) and !(options[:error_disable])
    end

    def error_message(field)
      if has_error?(field)
        @object.errors[field].collect { |msg| concat(content_tag(:li, msg)) }
      end
    end

    def grid_system_class(options={})
      "col-#{options[:control_col] || default_grid_system}-#{options[:grid_system] || default_offset_control_col}"
    end

    def grid_system_offset_class(options={})
      "col-#{options[:control_col] || default_grid_system}-offset-#{options[:grid_system] || default_offset_control_col}"
    end

    def default_offset_control_col
      3
    end

    def default_horizontal_label_col
      3
    end

    def default_control_col
      12
    end

    def default_horizontal_control_col
      7
    end

    def default_date_col
      4
    end

    def default_grid_system
      "sm"
    end

    def error_class
      "has-error"
    end
  end
end