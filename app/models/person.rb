# == Schema Information
#
# Table name: people
#
#  id              :integer          not null, primary key
#  last_name       :string(255)
#  first_name      :string(255)
#  middle_name     :string(255)
#  birthday        :date
#  created_user    :integer
#  updated_user    :integer
#  personable_id   :integer
#  personable_type :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  sex             :string(255)
#

class Person < ActiveRecord::Base
  belongs_to :personable, polymorphic: true
  belongs_to :creator, class_name: "User", foreign_key: "created_user"
  belongs_to :refresher, class_name: "User", foreign_key: "updated_user"

  VALID_NAME_REGEX = /\A(([a-z -]*)|([а-я -]*))\z/i
  VALID_SEX_REGEX = /\A(M{1}|F{1})\z/i

  before_save :set_name

  validates :last_name, presence: true,
            format: { with: VALID_NAME_REGEX,
                      message: I18n.t("models.person.validates_messages.format") },
            length: { maximum: 50,
                      message: I18n.t("models.person.validates_messages.length") }

  validates :first_name, presence: true,
            format: { with: VALID_NAME_REGEX,
                      message: I18n.t("models.person.validates_messages.format") },
            length: { maximum: 50,
                      message: I18n.t("models.person.validates_messages.length") }

  validates :middle_name,
            format: { with: VALID_NAME_REGEX,
                      message: I18n.t("models.person.validates_messages.format"),
                      allow_blank: true },
            length: { maximum: 50,
                      message: I18n.t("models.person.validates_messages.length") }

  validates :birthday, presence: true,
            date: { before: Proc.new { Date.today }, message: I18n.t("models.person.validates_messages.birthday") }

  validates :sex, presence: true,
            inclusion: { in: %w(M F),
                         message: I18n.t("models.person.validates_messages.sex") }

  private

  def set_name
    self.last_name = normalize_name(self.last_name)
    self.first_name = normalize_name(self.first_name)
    self.middle_name = normalize_name(self.middle_name)
  end

  def normalize_name(name)
    if name.blank?
      name = nil
    else
      name.gsub!(/^[ -]*|[ -]*$/, "")
      name.gsub!(/[ ]*[-]{2,}[ ]*/, "-")
      name.gsub!(/[ ]{2,}/, " ")
      name.gsub!(/[a-zа-я]+/i) { |s| s.capitalize }
    end
  end
end