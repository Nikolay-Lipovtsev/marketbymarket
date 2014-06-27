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

require "spec_helper"

describe Person do

  let(:person) { FactoryGirl.create :person }

  subject { person }

  it { expect(person).to respond_to(:last_name) }
  it { expect(person).to respond_to(:first_name) }
  it { expect(person).to respond_to(:middle_name) }
  it { expect(person).to respond_to(:birthday) }
  it { expect(person).to respond_to(:sex) }

  context " when last name is not present" do
    before { person.last_name = " " }
    it { expect(person).not_to be_valid }
  end

  context "when first name is not present" do
    before { person.first_name = " " }
    it { expect(person).not_to be_valid }
  end

  context "when middle name is not present" do
    before { person.middle_name = " " }
    it { expect(person).to be_valid }
  end

  context "when birthday is not present" do
    before { person.birthday = nil }
    it { expect(person).not_to be_valid }
  end

  context "when sex is not present" do
    before { person.sex = nil }
    it { expect(person).not_to be_valid }
  end

  context "when last name is too long" do
    before { person.last_name = "A" + ( "a" * 50 ) }
    it { expect(person).not_to be_valid }
  end

  context "when first name is too long" do
    before { person.first_name = "A" + ( "a" * 50 ) }
    it { expect(person).not_to be_valid }
  end

  context "when middle name is too long" do
    before { person.middle_name = "A" + ( "a" * 50 ) }
    it { expect(person).not_to be_valid }
  end

  context "when birthday later than today" do
    before { person.birthday = 20.days.since }
    it { expect(person).not_to be_valid }
  end

  context "when last name format is invalid" do
    let(:name) { %w[Ефремоv Ivanov. Iva_nov Iva@nov] }
    it "should be invalid" do
      name.each do |invalid_name|
        person.last_name = invalid_name
        expect(person).not_to be_valid
      end
    end
  end

  context "when sex is not M or F" do
    before { person.sex = "TEST" }
    it { expect(person).not_to be_valid }
  end
end
