module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Market by market"
    if page_title.empty?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end

  def language_list
    [['Русский', 'ru'], ['English', 'en']]
  end

  def class_for_invalid_input(obj, name)
    unless obj.nil?
      obj.errors[name].any? ? " has-error" : ""
    end
  end

  def class_for_date_input(name, input_type)
    if input_type == "date"
      name.to_s == "birthday" ? " sandbox-container birthday" : " sandbox-container gefault"
    end
  end

  def error_msg_for_invalid_input(obj, name)
    unless obj.nil?
      if obj.errors[name].any?
        content_tag :ui, class: "text-danger" do
          obj.errors[name].collect { |msg| concat(content_tag(:li, msg)) }
        end
      end
    end
  end

  def sign_page_input_tag(controller_name, group, name, ico = nil, input_type = "text", size = "12", popover = true)
    content_tag :div, class: "row" do
      content_tag :div, class: "col-xs-" + size do
        content_tag :div, class:  "form-group left-inner-addon
        #{class_for_invalid_input(group.object, name).to_s}
        #{class_for_date_input(name, input_type).to_s}" do

          (ico ? content_tag(:i, "", class: "fa fa-#{ico} fa-fw text-muted") : "") +

              group.text_field( name,
                                id: name.to_s.gsub("_", "-"),
                                class: "form-control" + (" popover-add" if popover).to_s,
                                type: input_type,
                                placeholder: "#{t(controller_name + '.placeholder.' + name.to_s)}",
                                data: { container: "body",
                                        toggle: "popover",
                                        placement: "bottom",
                                        content: ("#{t(controller_name + '.popover.' + name.to_s)}" if popover) }) +

              error_msg_for_invalid_input(group.object, name)
        end
      end
    end
  end
end
