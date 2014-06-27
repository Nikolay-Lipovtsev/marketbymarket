require "spec_helper"

describe "sign up page" do

  subject { page }

  context "visit sign up page" do
    before { visit signup_path }
    it { expect(page).to have_title(correct_title("Регистрация")) }
    it { expect(page).to have_selector("input[type=text][name='user[person_attributes][last_name]']") }
    it { expect(page).to have_selector("input[type=text][name='user[person_attributes][first_name]']") }
    it { expect(page).to have_selector("input[type=date][name='user[person_attributes][birthday]']") }
    it { expect(page).to have_selector("input[type=radio][name='user[person_attributes][sex]'][value='M']") }
    it { expect(page).to have_selector("input[type=radio][name='user[person_attributes][sex]'][value='F']") }
    it { expect(page).to have_selector("input[type=email][name='user[email]']") }
    it { expect(page).to have_selector("input[type=password][name='user[password]']") }
    it { expect(page).to have_selector("input[type=password][name='user[password_confirmation]']") }
    it { expect(page).to have_selector("button[type=button]", text: 'Зарегистрироваться') }
    it { expect(page).to have_selector("input[type=submit][value='Я согласен']") }
  end

  describe "displays request for agreement", js: true do
    before { visit signup_path }
    context "without pressing the button" do
      it "should not displays request for agreement message" do
        expect(page).to have_selector("#request-for-agreement", visible: false)
      end
    end

    context "with pressing the button" do
      it "should displays request for agreement message" do
        click_button "Зарегистрироваться"
        expect(page).to have_selector("#request-for-agreement")
      end
    end
  end

  describe "sign up" do
    before do
      visit signup_path
      click_button "Зарегистрироваться"
    end

    context "with invalid information" do
      it "should not create a project and user" do
        expect { click_button "Я согласен" }.not_to change(User, :count)
      end
    end

    context "with valid information" do
      let(:user) { FactoryGirl.build(:user) }
      before do
        fill_in "user[person_attributes][last_name]",  with: user.person.last_name
        fill_in "user[person_attributes][first_name]", with: user.person.first_name
        fill_in "user[person_attributes][birthday]",   with: user.person.birthday
        fill_in "user[email]",                         with: user.email
        fill_in "user[password]",                      with: user.password
        fill_in "user[password_confirmation]",         with: user.password_confirmation
        click_button "Зарегистрироваться"
      end
      it "should create a project and user" do
        expect { click_button "Я согласен" }.to change(User, :count).by(1)
      end
    end
  end
end