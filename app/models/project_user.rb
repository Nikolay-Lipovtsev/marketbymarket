# == Schema Information
#
# Table name: project_users
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  project_id   :integer
#  created_user :integer
#  updated_user :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class ProjectUser < ActiveRecord::Base
end
