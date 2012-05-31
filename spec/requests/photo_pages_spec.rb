require 'spec_helper'

describe "Photo pages" do

  let(:album) { FactoryGirl.create(:album) }

  subject { page }

  describe "create new photo" do
    before { visit new_photo_path(album_id: album.id) }

    describe "with valid information" do
      before { attach_file("photo_image", File.join(Rails.root, 'spec', 'support', 'photos', 'images', 'rails.png')) }
      it "should create a photo" do
        expect { click_button "Add Photo" }.to change(Photo, :count)
      end
    end

    describe "with invalid information" do
       it "should not create photo when no file is provided" do
          expect { click_button "Add Photo" }.to_not change(Photo, :count)
       end
    end
  end

  describe "show" do
    let(:photo) { FactoryGirl.create(:photo, album: album) }
    before { visit photo_path(photo) }

    describe "page" do
      it { should have_selector('h1', text: photo.name) }
      it { should have_selector('title', text: full_title(photo.name)) }
      it { should have_selector('img', src: photo.image_url.to_s) }
    end
  end
end
