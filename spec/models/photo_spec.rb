require 'spec_helper'

describe "Photo" do
  let(:album) { FactoryGirl.create(:album) }
  before do
    @photo = FactoryGirl.build(:photo, album: album) 
  end
  
  subject { @photo }
  
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:image) }

  it { should be_valid }

  describe "without an image" do
     before { @photo.remove_image! }
     it { should_not be_valid }
  end
end
