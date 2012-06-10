require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    let(:submit) { "Sign in" }

    it { should have_selector('h1', text: 'Sign in') }
    it { should have_selector('title', text: full_title('Sign in')) }

    describe "with invalid information" do
      before { click_button submit }
      it { should have_selector('div.alert.alert-error', text: "Error") }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button submit
      end

      it { should have_selector('div.alert.alert-success', text:  "Successfully logged in.") }
      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
end
