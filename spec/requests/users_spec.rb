require 'spec_helper'

describe User do

  context 'un-registered user' do
    it 'should show login page to user' do
      visit root_path
      page.should have_content('Sign in')
    end

    it 'should allow user to sign up' do
      visit root_path
      click_link 'Sign up'
      fill_in 'First name', :with => 'Matt'
      fill_in 'Last name', :with => 'Rails'
      fill_in 'Email', :with => 'matt@rails.com'
      fill_in 'Password', :with => 'mattrails'
      fill_in 'Password confirmation', :with => 'mattrails'
      click_button 'Sign up'
      page.should have_content("Signed in as matt@rails.com")
      current_path.should == root_path
    end
  end

  context 'registered user' do
    before do
      @user = Factory(:user)
    end

    it 'should allow user to sign in' do
      login_as @user
      page.should have_content('Listing posts') 
    end

    it 'should allow user to sign out' do
      login_as @user
      log_out
      page.should have_content('Sign up or Sign in')
    end
  end

end