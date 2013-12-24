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
#

require 'spec_helper'

describe User do

  #before { @user = User.new(email: "User@example.com", password: "foobar", password_confirmation: "foobar") }
  before { @user = FactoryGirl.build :user }

  subject { @user }

  it { expect(@user).to respond_to(:email) }
  it { expect(@user).to respond_to(:password_digest) }
  it { expect(@user).to respond_to(:password) }
  it { expect(@user).to respond_to(:password_confirmation) }
  it { expect(@user).to be_valid }

  describe "When email is not present" do
    before { @user.email = " " }
    it { expect(@user).not_to be_valid }
  end

  describe "When password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { expect(@user).not_to be_valid }
  end

  describe "When password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { expect(@user).not_to be_valid }
  end

  describe "When password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { expect(@user).not_to be_valid }
  end

  describe "Return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "With valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "With invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "With a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "When email is too long" do
    before { @user.email = "a" * 51 }
    it { should_not be_valid }
  end

  describe "When email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "When email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "When email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
end