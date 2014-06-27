include ApplicationHelper

def correct_title(page_title)
  base_title = "Market by market"
  if page_title.empty?
    base_title
  else
    "#{page_title} - #{base_title}"
  end
end

def short_user_name(user)
  "#{user.person.first_name} #{user.person.last_name}"
end

def valid_signin(user)
  fill_in "session[email]",    with: user.email
  fill_in "session[password]", with: user.password
  click_button "Войти"
end