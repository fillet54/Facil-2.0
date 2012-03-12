require 'spec_helper'

describe "Album pages" do

  let(:album) { FactoryGirl.create(:album) } 
  
  subject { page }

  describe "index page" do
    before { visit albums_path }

    it { should have_selector('h1',    text: "All Albums") }
    it { should have_selector('title', text: full_title('Albums')) }
    it { should have_link('Create Album') }

    describe "when clicking on create album" do
      before { click_link "Create Album" }

      it { should have_selector('h1', text: 'Create Album') }
    end

    describe "pagination" do
      before(:all) { 40.times { FactoryGirl.create(:album) } }
      after(:all) { Album.delete_all }
      
      it { should have_link('Next') }
      it { should have_link('2') }

      it "should list all albums" do
        Album.all[0..29].each do |album|
          page.should have_selector('li', text: album.name)
        end
      end

      describe "when clicking on an album" do
        before { click_link "Album 1" }
        
        it { should have_selector('h1', text: 'Album 1') }
      end
    end
  end

  describe "show page" do
    before { visit album_path(album) }

    it { should have_selector('h1', text: album.name) }
    it { should have_link("Add Photo") }

    describe "pagination" do
      before(:all) { 40.times { FactoryGirl.create(:photo, album: album) } }
      after(:all) { Album.delete_all }

      it { should have_link('Next') }
      it { should have_link('2') }

      it "should display all photos" do
        album.photos[0..29].each do |photo|
          page.should have_selector('li', text: photo.name)
        end
      end
    end

    describe "when clicking on 'Add Photo'" do
      before { click_link "Add Photo" }

      it { should have_selector('h1', text: 'Add New Photo') }
      it { should have_content(album.name) }
    end
  end
  
  describe "create album page" do
    before { visit new_album_path }

    it { should have_selector('h1',    text: "Create Album") }
    it { should have_selector('title', text: full_title("Create Album") ) }

    describe "with invalid information" do
      it "should not create an album" do
        expect { click_button "Create Album" }.not_to change(Album, :count)
      end
    end

    describe "error message" do
      before { click_button "Create Album" } 

      let(:error) { 'The form contains 1 error' }

      it { should have_selector('h1',    text: "Create Album") }
      it { should have_content(error) }
    end

    describe "with valid information" do
      before { fill_in "Name", with: "New Album" }

      it "should create an album" do
        expect { click_button "Create Album" }.to change(Album, :count)
      end

      describe "flash message" do
        before { click_button "Create Album" }

        it { should have_content("Album was created successfully") }
      end
    end
  end
end
