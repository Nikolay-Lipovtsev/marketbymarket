require 'spec_helper'

describe "Sign up page" do

  subject { page }

  context "Visit sign up page" do

    before { visit signup_path }

    it { expect(page).to have_title("Market by market - регистрация") }
    it { expect(page).to have_selector("input[type=text][name='user[person_attributes][last_name]']") }
    it { expect(page).to have_selector("input[type=text][name='user[person_attributes][first_name]']") }
    it { expect(page).to have_selector("input[type=date][name='user[person_attributes][birthday]']") }
    it { expect(page).to have_selector("input[type=email][name='user[email]']") }
    it { expect(page).to have_selector("input[type=password][name='user[password]']") }
    it { expect(page).to have_selector("input[type=password][name='user[password_confirmation]']") }
    it { expect(page).to have_selector("button[type=button]", text: 'Зарегистрироваться') }
    it { expect(page).to have_selector("input[type=submit][value='Я согласен']") }
  end

  describe "Displays request for agreement", js: true do

    before { visit signup_path }

    context "No click request for agreement" do
      it "should not displays request for agreement message" do
        expect(page).to have_selector("#request-for-agreement", visible: false)
      end
    end

    context "Click request for agreement" do
      it "should displays request for agreement message" do
        click_button "Зарегистрироваться"
        expect(page).to have_selector("#request-for-agreement")
      end
    end
  end

  describe "Sign up" do

    before do
      visit signup_path
      click_button "Зарегистрироваться"
    end

    context "With invalid information" do

      it "should not create a project and user" do
        expect { click_button "Я согласен" }.not_to change(User, :count)
        #pending "Test is not ready yet"
      end
    end

    context "With valid information" do

      let(:person) { FactoryGirl.build(:person) }
      #let(:user) { FactoryGirl.build(:user) }
      #let(:user) { FactoryGirl.build(:user) }
      #let(:person) { FactoryGirl.create(:person) }
      #let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "user[person_attributes][last_name]",  with: person.last_name
        fill_in "user[person_attributes][first_name]", with: person.first_name
        fill_in "user[person_attributes][birthday]",   with: person.birthday
        fill_in "user[email]",                         with: person.personable.email
        fill_in "user[password]",                      with: person.personable.password
        fill_in "user[password_confirmation]",         with: person.personable.password_confirmation
        click_button "Зарегистрироваться"
      end

      it "should create a project and user" do
        expect { click_button "Я согласен" }.to change(User, :count).by(1)
        #pending "Test is not ready yet"
      end
    end
  end
end