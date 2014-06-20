# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  created_user :integer
#  updated_user :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Project do
  pending "add some examples to (or delete) #{__FILE__}"
end