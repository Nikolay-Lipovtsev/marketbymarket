require 'spec_helper'

describe "Sign up page" do

  context "Visit sign up page" do
    before { visit signup_path }
    it { expect(page).to have_title("Market by market - регистрация") }
    it { expect(page).to have_selector("input[type=text][name='project[name]']") }
    it { expect(page).to have_selector("input[type=email][name='project[users_attributes][0][email]']") }
    it { expect(page).to have_selector("input[type=password][name='project[users_attributes][0][password]']") }
    it { expect(page).to have_selector("input[type=password][name='project[users_attributes][0][password_confirmation]']") }
    it { expect(page).to have_selector("button[type=button]", text: 'Sign up') }
    it { expect(page).to have_selector("input[type=submit][value='Зарегистрироваться']") }
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
        click_button "Sign up"
        expect(page).to have_selector("#request-for-agreement")
      end
    end
  end

  describe "Sign up" do
    before { visit signup_path }

    context "With invalid information" do
      before { click_button "Sign up" }

      it "should not create a project and user" do
        expect { click_button "Зарегистрироваться" }.not_to change(Project, :count)
        #pending "Test is not ready yet"
      end
    end

    context "With valid information" do
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