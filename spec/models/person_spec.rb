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
#

require 'spec_helper'

describe Person do

  let(:person) { FactoryGirl.create :person }

  subject { person }

  it { expect(person).to respond_to(:last_name) }
  it { expect(person).to respond_to(:first_name) }
  it { expect(person).to respond_to(:middle_name) }
  it { expect(person).to respond_to(:birthday) }

  describe "When last name is not present" do
    before { person.last_name = " " }
    it { expect(person).not_to be_valid }
  end

  describe "When first name is not present" do
    before { person.first_name = " " }
    it { expect(person).not_to be_valid }
  end

  describe "When middle name is not present" do
    before { person.middle_name = " " }
    it { expect(person).not_to be_valid }
  end

  describe "When last name is too long" do
    before { person.first_name = "A" + ( "a" * 51 ) }
    it { expect(person).not_to be_valid }
  end

  describe "When last name format is invalid" do
    it "should be invalid" do
      name = %w[  ivanov IvanoV Iva--nov Ivanov. Iva_nov Iva@nov]
      name.each do |invalid_name|
        person.last_name = invalid_name
        person.should_not be_valid
      end
    end
  end

  describe "When first name format is invalid" do
    it "should be invalid" do
      name = %w[  ivanov IvanoV Iva--nov Ivanov. Iva_nov Iva@nov]
      name.each do |invalid_name|
        person.first_name = invalid_name
        person.should_not be_valid
      end
    end
  end

  describe "When middle name format is invalid" do
    it "should be invalid" do
      name = %w[  ivanov IvanoV Iva--nov Ivanov. Iva_nov Iva@nov]
      name.each do |invalid_name|
        person.middle_name = invalid_name
        person.should_not be_valid
      end
    end
  end

end
