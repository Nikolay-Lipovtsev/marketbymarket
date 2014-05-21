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

require 'spec_helper'

describe UserProject do
  pending "add some examples to (or delete) #{__FILE__}"
end
