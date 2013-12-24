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
  before { @project = FactoryGirl.build :project }

  subject { @project }

  it { expect(@project).to respond_to(:name) }
  it { expect(@project).to be_valid }

  describe "When name is not present" do
    before { @project.name = " " }
    it { expect(@project).not_to be_valid }
  end

  describe "When name is too long" do
    before { @project.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "When name format is invalid" do
    it "should be invalid" do
      names = %w[user@foo,com user_at-foo.org example.user@foo. foo@bar&baz.com foo()bar+baz.com]
      names.each do |invalid_names|
        @project.name = invalid_names
        @project.should_not be_valid
      end
    end
  end

  describe "When name format is valid" do
    it "should be valid" do
      names = %w[my_company MyCompany Company]
      names.each do |valid_names|
        @project.name = valid_names
        @project.should be_valid
      end
    end
  end

  describe "When name is already taken" do
    before do
      project_with_same_name = @project.dup
      project_with_same_name.name = @project.name.upcase
      project_with_same_name.save
    end

    it { should_not be_valid }
  end
end
