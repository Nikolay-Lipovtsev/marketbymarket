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
#  language        :string(255)
#

require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create :user }
  subject { user }
  it { expect(user).to respond_to(:email) }
  it { expect(user).to respond_to(:password_digest) }
  it { expect(user).to respond_to(:password) }
  it { expect(user).to respond_to(:password_confirmation) }
  it { expect(user).to respond_to(:remember_token) }
  it { expect(user).to respond_to(:authenticate) }
  it { expect(user).to be_valid }

  context "when email is not present" do
    before { user.email = " " }
    it { expect(user).not_to be_valid }
  end

  context "when password is not present" do
    before { user.password = user.password_confirmation = " " }
    it { expect(user).not_to be_valid }
  end

  context "when password doesn't match confirmation" do
    before { user.password_confirmation = "mismatch" }
    it { expect(user).not_to be_valid }
  end

  context "when password confirmation is nil" do
    before { user.password_confirmation = nil }
    it { expect(user).not_to be_valid }
  end

  describe "return value of authenticate method" do
    before { user.save }
    let(:found_user) { User.find_by(email: user.email) }

    context "with valid password" do
      it { should eq found_user.authenticate(user.password) }
    end

    context "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

  context "with a password that's too short" do
    before { user.password = user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  context "when email is too long" do
    before { user.email = "a" * 51 }
    it { should_not be_valid }
  end

  context "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        user.email = invalid_address
        user.should_not be_valid
      end
    end
  end

  context "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        user.email = valid_address
        user.should be_valid
      end
    end
  end

  context "when email address is already taken" do
    let(:user_with_same_email) { user.dup }
    before do
      user_with_same_email.email.upcase!
      user_with_same_email.save
    end

    it { user_with_same_email.should_not be_valid }
  end

  describe "remember token" do
    before { user.save }
    it { expect(user.remember_token).not_to be_blank }
  end
end
