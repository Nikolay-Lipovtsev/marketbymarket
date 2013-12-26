require 'spec_helper'

describe "Authentication" do

  describe "Signin page" do
    before { visit signin_path }

    it { expect(page).to have_title("Market by market - войти") }
    it { expect(page).to have_selector("input[type=email][name='session[email]']")  }
    it { expect(page).to have_selector("input[type=password][name='session[password]']") }
    it { expect(page).to have_selector("input[type=submit][value='Войти']") }
  end

  describe "Sign in" do
    before { visit signin_path }

    context "With invalid information" do
      before { click_button "Войти" }

      it { expect(page).to have_title("Market by market - войти") }
    end

    context "With valid information" do
      let(:project) { FactoryGirl.create(:project) }
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "session[email]",    with: user.email.upcase
        fill_in "session[password]", with: user.password
        click_button "Войти"
      end

      it { expect(page).not_to have_title("Market by market - войти") }
      it { expect(page).not_to have_link("Профиль", href: project_path(project.name)) }
      it { expect(page).not_to have_link("Выйти", href: signout_path) }

      context "After visiting another page" do
        before { click_link "Главная" }
        it { expect(page).to have_link('Выйти') }
      end

      context "Followed by signout" do
        before { click_link "Выход" }
        it { expect(page).to have_link('Войти') }
      end
    end
  end
end
