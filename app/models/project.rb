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

class Project < ActiveRecord::Base
  has_many :project_users, dependent: :destroy
#  accepts_nested_attributes_for :users

  before_save { name.downcase! }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_NAME_REGEX = /\A[\w\_]+\z/i
  validates :name, presence: true, format: { with: VALID_NAME_REGEX }, uniqueness: { case_sensitive: false }

  def to_param
    self.name
  end
end
