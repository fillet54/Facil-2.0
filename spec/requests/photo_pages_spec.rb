require 'spec_helper'

describe "Photo pages" do

  let(:album) { FactoryGirl.create(:album) }

  subject { page }

  describe "create new photo" do
    before { visit new_photo_path(album_id: album.id) }

    describe "with valid information" do
      it "should create a photo" do
        expect { click_button "Add Photo" }.to change(Photo, :count)
      end
    end
  end
end
