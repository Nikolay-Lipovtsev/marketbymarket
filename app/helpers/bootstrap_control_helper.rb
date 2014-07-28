module BootstrapControlHelper
class BootstrapForm < ActionView::Helpers::FormBuilder

  COMMON_OPTIONS = [:layout, :label_class, :label_col, :label_offset, :label_text, :control_class, :control_col,
                    :control_offset, :invisible_label, :placeholder, :popover, :error_disable, :row_disable, :required]

  LABEL_OPTIONS = [:layout, :label_class, :label_col, :label_text, :label_offset, :invisible_label]

  CONTROL_OPTIONS = [:layout, :control_class, :control_col, :control_offset]

  FIELD_HELPERS = %w{color_field date_field datetime_field datetime_local_field
  email_field month_field number_field password_field phone_field
  range_field search_field telephone_field text_area text_field time_field
  url_field week_field}

  DATE_SELECT_HELPERS = %w{date_select time_select datetime_select}

  def self.create_tagged_field(method_name)
    define_method(method_name) do |obj, method, options = {}|
      generate_form_group(obj, method, options) do
        super(obj, method, options.except(*COMMON_OPTIONS))
      end
    end
  end

  delegate :content_tag, :capture, :concat, to: :@template

  def initialize(object_name, object, template,  options)
    @object_name, @object, @template,  @options = object_name, object, template, options

    super
  end

  FIELD_HELPERS.each do |method_name|
    create_tagged_field(method_name)
  end

  def generate_form_group_row(options = {})
    options[:control_col] ? content_tag(:div, "", class: "row") { yield } : yield
  end

  def generate_form_group(obj, method, options = {}, &block)
    generate_form_group_row(options.slice(:control_col)) do
      if options[:control_col] && options[:layout].nil?
        options[:class] = [options[:class], grid_system_class(options[:control_col])].compact.join(" ")
      end
      options[:class] = [options[:class], "form-group"].compact.join(" ")
      options[:class] = [options[:class], "has-error"].compact.join(" ") if has_error?(obj, method)
      content_tag(:div, class: options[:class]) do
        generate_label(obj,
                       method,
                       options.slice(*LABEL_OPTIONS)).concat(generate_control(options, &block))
      end
    end
  end

  def generate_label(obj, method, options={})
    options[:class] = label_class(options)
    label(method, options[:label_text], options.slice(:class))
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
      options[:label_col]
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

  def has_error?(obj, method)
    obj.respond_to?(:errors) && !(method.nil? || obj.errors[method].empty?)
  end

  def grid_system_class(col=default_control_col)
    "col-#{default_grid_system}-#{col}" if (1..12).include?(col)
  end

  def grid_system_offset_class(col=default_offset_control_col)
    "col-#{default_grid_system}-offset-#{col}" if (1..12).include?(col)
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