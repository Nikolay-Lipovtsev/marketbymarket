module UsersHelper
  def short_user_name(user)
    "#{user.person.first_name} #{user.person.last_name}"
  end
end
