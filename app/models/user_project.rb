# == Schema Information
#
# Table name: user_projects
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  project_id   :integer
#  created_user :integer
#  updated_user :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class UserProject < ActiveRecord::Base

  belongs_to :user
  belongs_to :project
end
