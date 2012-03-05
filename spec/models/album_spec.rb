require 'spec_helper'

describe "Album" do

  before do
    @album = Album.new(name: "Album 1", description: "Album 1 Description")
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
end
