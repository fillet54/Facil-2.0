require 'spec_helper'

describe "Album" do

  before do
    @album = FactoryGirl.build(:album)
  end

  subject { @album }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:photos) }
  it { should respond_to(:image_url) }

  it { should be_valid }

  describe "when name is blank" do
    before { @album.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @album.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "photo association" do
    before { @album.save! }
    let!(:photo1) { FactoryGirl.create(:photo, album: @album) }
    let!(:photo2) { FactoryGirl.create(:photo, album: @album) }
    
    its(:photos) {should include(photo1, photo2) } 

    it "should destroy associated photos" do
       photos = @album.photos
       @album.destroy
       photos.each do |photo|
         Photo.find_by_id(photo.id).should be_nil
       end
    end
  end

  describe "preview image" do
    describe "without any photos" do
      its(:image_url) { should eq("http://placehold.it/260x180") }
    end

    describe "with multiple photos" do
      before { @album.save }
      let(:photo1) { FactoryGirl.create(:photo, album: @album) }
      let(:photo2) { FactoryGirl.create(:photo, album: @album) }

      its(:image_url) { should eq(photo1.image_url(:thumb)) }
    end
  end
end
