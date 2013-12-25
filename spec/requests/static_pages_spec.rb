require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { expect(page).to have_title("Market by market - регистрация") }
    it { expect(page).not_to have_title('| Home') }
    it { expect(page).to have_selector('h1', text: 'Market by market') }
    it { expect(page).to have_link('Главная', href: root_path) }
  end
end
