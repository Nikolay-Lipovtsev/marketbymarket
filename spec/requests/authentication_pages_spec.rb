require 'spec_helper'

describe "authentication" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  describe "sign in page" do
    before { visit signin_path }
    it { expect(page).to have_title(correct_title("Вход")) }
    it { expect(page).to have_selector("input[type=email][name='session[email]']")  }
    it { expect(page).to have_selector("input[type=password][name='session[password]']") }
    it { expect(page).to have_selector("input[type=submit][value='Войти']") }
  end

  describe "sign in" do
    before { visit signin_path }
    context "with invalid information" do
      before { click_button "Войти" }
      it { expect(page).to have_selector("input[type=submit][value='Войти']") }
    end

    context "with valid information" do
      before { valid_signin(user) }
      it { expect(page).to have_title(correct_title(short_user_name(user))) }
      it { expect(page).to have_link("Профиль", href: user_path(user) + "?locale=ru") }
      it { expect(page).to have_link("Выход", href: signout_path  + "?locale=ru") }

      context "after visiting another page" do
        before { click_link "Редактировать" }
        it { expect(page).to have_link("Выход") }
      end

      context "followed by sign out" do
        before { click_link "Выход" }
        it { expect(page).to have_link("Войти") }
      end
    end
  end
end
