require 'spec_helper'

describe "Authentication" do

  describe "Signin page" do
    before { visit signin_path }

    it { expect(page).to have_title("Market by market - войти") }
    it { expect(page).to have_selector("input[type=email][name='user[email]']")  }
    it { expect(page).to have_selector("input[type=password][name='user[password]']") }
    it { expect(page).to have_selector("input[type=submit][value='Войти']") }
  end

  describe "Sign in" do
    before { visit signin_path }

    context "With invalid information" do
      before { click_button "Войти" }

      it { expect(page).to have_title("Market by market - войти") }
      it { expect(page).to have_selector("div.alert.alert-error", text: "Invalid")  }
    end

    context "With valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "user[email]",    with: user.email.upcase
        fill_in "user[password]", with: user.password
        click_button "Войти"
      end

      it { expect(page).not_to have_title("Market by market - войти") }
      it { expect(page).not_to have_link("Профиль", href: user_path(user)) }
      it { expect(page).not_to have_link("Выйти", href: signout_path) }
    end
  end
end
