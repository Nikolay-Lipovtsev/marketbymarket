require 'spec_helper'

describe "static pages" do
  subject { page }
  describe "home page" do
    before { visit root_path }
    it { expect(page).to have_title(correct_title("Главная страница")) }
    it { expect(page).not_to have_title("| Home") }
    it { expect(page).to have_selector("h1", text: "Market by market") }
    it { expect(page).to have_link("Главная", href: root_path + '?locale=ru') }
    it { expect(page).to have_link("Зарегистрироваться", href: signup_path + '?locale=ru') }
  end
end
