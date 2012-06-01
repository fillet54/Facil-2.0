require 'spec_helper'

describe "Album pages" do
  
  subject { page }

  describe "index page" do
    let(:album) { FactoryGirl.create(:album) } 
    before { visit albums_path }

    it { should have_selector('h1',    text: "All Albums") }
    it { should have_selector('title', text: full_title('Albums')) }
    it { should have_link('Create Album', href: new_album_path) }

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
          page.should have_selector('img', src: album.image_url)
        end
      end

      describe "when clicking on an album" do
        before { click_link "Album 1" }
        
        it { should have_selector('h1', text: 'Album 1') }
      end
    end
  end

  describe "show" do
    let(:album) { FactoryGirl.create(:album) }
    before { visit album_path(album) }

    describe "page" do
      it { should have_selector('h1', text: album.name) }
      it { should have_selector('h2', text: album.description) }
      it { should have_link("Add Photo", href: new_photo_path(album_id: album)) }
      it { should have_link("Edit Album", href: edit_album_path(album)) }
    end

    describe "pagination" do
      before(:all) { 40.times { FactoryGirl.create(:photo, album: album) } }
      after(:all) { Album.delete_all }

      it { should have_link('Next') }
      it { should have_link('2') }

      it "should display all photos" do
        album.photos[0..29].each do |photo|
          page.should have_selector('li', text: photo.name)
          page.should have_link(photo.name, :href => photo_path(photo))
        end
      end
    end      

    describe "when clicking on 'Add Photo'" do
      before { click_link "Add Photo" }

      it { should have_selector('h1', text: 'Add New Photo') }
      it { should have_content(album.name) }
    end

    describe "in place editing" do
      before(:all) { FactoryGirl.create(:photo, album: album) }
      after(:all) { Album.delete_all }

      describe "album properties", :js => true do
        before do
          visit album_path(album)
          bip_text album, :name, "New Album Name"
          bip_text album, :description, "New Album Description"
        end

        it { should have_content("New Album Name") }
        it { should have_content("New Album Description") }
      end
    end

    describe "when clicking on 'Delete Album'" do
      before { click_link "Delete Album" }
      it { Album.find_by_id(album.id).should be nil }
    end
  end
  
  describe "new" do
    before { visit new_album_path }

    describe "page" do
      it { should have_selector('h1',    text: "Create Album") }
      it { should have_selector('title', text: full_title("Create Album") ) }
    end

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
  
  describe "edit" do
    let(:album) { FactoryGirl.create(:album) }
    before { visit edit_album_path(album) }

    describe "page" do
      it { should have_selector('h1',    text: "Edit Album") }
      it { should have_selector('title', text: full_title("Edit Album")) }
      it { should have_button('Update Album') }
    end
    
    describe "with invalid information" do
      let(:error) { "The form contains 1 error" }
      before do
        fill_in "Name", with: ""
        click_button "Update Album" 
      end

      it { should have_content(error) }
    end

    describe "with valid information" do
      let(:album) { FactoryGirl.create(:album) }
      let(:new_name) { "New Album Name" }
      let(:new_description) { "New Album Description" }
      before do
        fill_in "Name",        with: new_name
        fill_in "Description", with: new_description
        click_button "Update Album"
      end

      it { should have_selector('title', text: full_title(new_name)) }
      it { should have_selector('h1',    text: new_name) }
      it { should have_selector('div.alert-success') }
    end
  end
end
