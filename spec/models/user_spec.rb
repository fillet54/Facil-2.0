require 'spec_helper'

describe "User" do

  before do
    @user = User.new(name: "Example User", email: "user@example.com") 
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email format is invalid" do
    it "should not be valid" do
      addresses = %w[$user@foo.com user@f$o.com user@foo.$om]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when the email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address should be downcased before saving" do
    before do 
      @user.email = @user.email.upcase
      @user.save
    end
    it "should have a downcased email" do
      User.find_by_email(@user.email).email.should == @user.email.downcase
    end
  end
end
