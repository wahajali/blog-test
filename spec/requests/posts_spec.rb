require 'spec_helper'


describe Post, "that have already been created" do

  before do
    @user = Factory(:user)
    @post = Factory(:post, :user => @user)
    login_as @user
  end

  after do
    log_out
  end

  it "should display listing by title" do
    visit posts_path
    page.should have_content(@post.title)
  end

  it "should display post title in show page" do
    visit post_path(@post)
    page.should have_content(@post.title)
  end

  it "should display post content in show page" do
    visit post_path(@post)
    page.should have_content(@post.content)
  end

  it "should allow content of post to be editable" do
    visit edit_post_path(@post)
    time = Time.now.to_s
    fill_in 'Content', :with => time
    click_button('Update Post')
    page.should have_content('Post was successfully updated.')
    visit post_path(@post)
    page.should have_content(time)
  end

  it "should allow title of post to be editable" do
    visit edit_post_path(@post)
    time = Time.now.to_s
    fill_in 'Title', :with => time
    fill_in 'Title', :with => time
    click_button('Update Post')
    page.should have_content('Post was successfully updated')
    visit post_path(@post)
    page.should have_content(time)
  end

  it "should show number of blog posts" do
    visit posts_path
    size = Post.find(:all).size
    page.should have_content(size.to_s)
  end

  it "should list user who posted the blog" do
    visit posts_path
    page.should have_content(@post.user.first_name)
    page.should have_content(@post.user.last_name)
  end
end

describe Post, "creation process" do
  before do
    @user = Factory(:user)
    @post = Factory(:post, :user => @user)
    login_as @user
  end

  after do
    log_out
  end
  it "should create a post and notify user" do
    visit new_post_path
    time = Time.now.to_s
    fill_in 'Title', :with => 'test post'
    fill_in 'Content', :with => time
    click_button('Create Post')
    page.should have_content('Post was successfully created')
  end

  it "should list all new articles" do
    visit new_post_path
    time = Time.now.to_s
    fill_in 'Title', :with => 'test post'
    fill_in 'Content', :with => time
    click_button('Create Post')
    page.should have_content(time)
  end
end

describe Post, "that have some information missing" do
  before do
    @user = Factory(:user)
    @post = Factory(:post, :user => @user)
    login_as @user
  end

  after do
    log_out
  end
  it "should not create post and display error if title is missing" do
    visit new_post_path
    fill_in 'Content', :with => 'test content'
    click_button('Create Post')
    page.should have_content("Title can't be blank")
  end

  it "should not create post and display error if content is missing" do
    visit new_post_path
    fill_in 'Title', :with => 'test content'
    click_button('Create Post')
    page.should have_content("Content can't be blank")
  end
end

