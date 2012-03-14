require 'spec_helper'

describe Photo do
  let(:album) { FactoryGirl.create(:album) }
  before do
    @photo = FactoryGirl.create(:photo, album: album) 
  end

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:image) }

  it { should be_valid }
end
