require 'spec_helper'

describe "Authentication" do

  describe "Signin page" do
    before { visit signin_path }

    it { expect(page).to have_title("Market by market - войти") }
    it { expect(page).to have_selector("input[type=email][name='user[email]']")  }
    it { expect(page).to have_selector("input[type=password][name='user[password]']") }
    it { expect(page).to have_selector("input[type=submit][value='Войти']") }
  end
end
