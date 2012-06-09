require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    let(:submit) { "Sign up" }

    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }
        it { should have_content("Email can't be blank") }
        it { should have_content("Password can't be blank") }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User" 
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after submission" do
        before { click_button submit }
        it { should have_content("Welcome to Facil") }
        it { should have_content("Example User") }
      end
    end
  end
end
