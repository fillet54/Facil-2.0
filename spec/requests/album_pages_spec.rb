require 'spec_helper'

describe "Album pages" do

  subject { page }

  describe "index" do
  
    let(:album) { FactoryGirl.create(:album) } 
    before do
      visit albums_path
    end 

    it { should have_selector('h1', text: "All Albums") }

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
    end
  end
end
