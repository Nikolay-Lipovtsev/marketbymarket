require 'spec_helper'

describe "Sign up page" do

  describe "Visit sign up page" do
    it "displays sign up page" do
      visit signup_path
      expect(page).to have_title("Market by market - регистрация")
      expect(page).to have_selector("input[type=text][name='project[name]']")
      expect(page).to have_selector("input[type=email][name='project[users_attributes][0][email]']")
      expect(page).to have_selector("input[type=password][name='project[users_attributes][0][password]']")
      expect(page).to have_selector("input[type=password][name='project[users_attributes][0][password_confirmation]']")
      expect(page).to have_selector("button[type=button]", text: 'Sign up')
      expect(page).to have_selector("input[type=submit][value='Зарегистрироваться']")
    end
  end

  describe "Displays request for agreement", js: true do
    before { visit signup_path }

    describe "No click request for agreement" do
      it "should not displays request for agreement message" do
        expect(page).to have_selector("#request-for-agreement", visible: false)
      end
    end

    describe "Click request for agreement" do
      it "should displays request for agreement message" do
        click_button "Sign up"
        expect(page).to have_selector("#request-for-agreement")
      end
    end
  end

  describe "Sign up" do
    before { visit signup_path }

    describe "With invalid information" do
      before { click_button "Sign up" }

      it "should not create a project and user" do
        expect { click_button "Зарегистрироваться" }.not_to change(Project, :count)
        #pending "Test is not ready yet"
      end
    end

    describe "With valid information" do
      before do
        fill_in "project[name]",                                       with: "my_company"
        fill_in "project[users_attributes][0][email]",                 with: "user@example.com"
        fill_in "project[users_attributes][0][password]",              with: "foobar"
        fill_in "project[users_attributes][0][password_confirmation]", with: "foobar"
        click_button "Sign up"
      end

      it "should create a project and user" do
        expect { click_button "Зарегистрироваться" }.to change(Project, :count).by(1)
        #pending "Test is not ready yet"
      end
    end
  end
end