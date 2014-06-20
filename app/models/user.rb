# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
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

  has_many :created_users, class_name: "User", foreign_key: "created_user"
  has_many :updated_users, class_name: "User", foreign_key: "updated_user"
  has_many :created_people, class_name: "Person", foreign_key: "created_user"
  has_many :updated_people, class_name: "Person", foreign_key: "updated_user"
  belongs_to :creator, class_name: "User", foreign_key: "created_user"
  belongs_to :refresher, class_name: "User", foreign_key: "updated_user"
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
  has_one :person, as: :personable, dependent: :destroy, validate: true
  accepts_nested_attributes_for :person

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX,
                      message: I18n.t("models.user.validates_messages.format") },
            length: { maximum: 50,
                      message: I18n.t("models.user.validates_messages.length") },
            uniqueness: { case_sensitive: false }

  validates :password_digest,
            presence: true

  validates :password,
            presence: true,
            length: { minimum: 6,
                      message: I18n.t("models.user.validates_messages.length") }

  validates :password_confirmation,
            presence: true

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
