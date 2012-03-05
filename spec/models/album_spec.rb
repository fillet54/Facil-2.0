require 'spec_helper'

describe "Album" do

  before do
    @album = FactoryGirl.create(:album)
  end

  subject { @album }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:photos) }

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
    before { @album.save }
    let(:photo1) { FactoryGirl.create(:photo, album: @album) }
    let(:photo2) { FactoryGirl.create(:photo, album: @album) }
    
    its(:photos) {should include(photo1, photo2) } 
  end
end
