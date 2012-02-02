require 'spec_helper'

describe User do
  it "should not be valid without email" do
  	user = Factory.build(:user, :email => nil)
  	user.should_not be_valid
  end

  it "should not be valid without first name" do
  	user = Factory.build(:user, :first_name => nil)
  	user.should_not be_valid
  end

  it "should not be valid without last_name" do
  	user = Factory.build(:user, :last_name => nil)
  	user.should_not be_valid
  end
end