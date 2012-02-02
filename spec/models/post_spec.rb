require 'spec_helper'

describe Post do

 it "should not be valid without content" do
   post = Factory(:post, :content => nil)
   post.should_not be_valid
 end

 it "should not be valid without user" do
   post = Factory(:post, :user_id => nil)
   post.should_not be_valid
 end

end
