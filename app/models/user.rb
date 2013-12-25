# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  project_id      :integer
#  email           :string(255)
#  password_digest :string(255)
#  created_user    :integer
#  updated_user    :integer
#  created_at      :datetime
#  updated_at      :datetime
#  remember_token  :string(255)
#

class User < ActiveRecord::Base

  has_secure_password

  belongs_to :project
  has_one    :user_profile, dependent: :destroy

  before_save { email.downcase! }

  validates :email, presence: true, length: { maximum: 50 }
  validates :password_digest, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
