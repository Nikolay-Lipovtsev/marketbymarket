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

  def to_b(str)
    str && str.match(/^(true|t|yes|y|1)$/i)
  end

  def language_list
    [['Русский', 'ru'], ['English', 'en']]
  end

  def sex_list
    [['Мужской', 'm'], ['Женский', 'f']]
  end
end
