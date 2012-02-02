require 'spec_helper'


describe Post, "that have already been created" do

  before(:all) do
    @user = Factory(:user)
    @post = Factory(:post, :user => @user)
    login_as @user
  end

  after(:all) do
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
    visit posts_path
    click_link 'Edit'
    time = Time.now.to_s
    fill_in 'Content', :with => time
    click_button('Create')
    page.should have_content('Post successfully edited')
    visit post_path(@post)
    page.should have_content(time)
  end

  it "should allow title of post to be editable" do
    visit posts_path
    click_link 'Edit'
    time = Time.now.to_s
    fill_in 'Title', :with => time
    click_button('Create')
    page.should have_content('Post successfully edited')
    visit post_path(@post)
    page.should have_content(time)
  end

  it "should show number of blog posts" do
    visit posts_path
    page.should have_content('1 Post')
  end

  it "should list user who posted the blog" do
    visit posts_path
    page.should have_content(@post.user.name)
  end
end

describe Post, "creation process" do
  before(:all) do
    @user = Factory(:user)
    @post = Factory(:post, :user => @user)
    login_as @user
  end

  after(:all) do
    log_out
  end
  it "should create a post and notify user" do
    visit new_post_path
    time = Time.now.to_s
    fill_in 'Title', :with => 'test post'
    fill_in 'Content', :with => time
    click_button('Create')
    page.should have_content('Post successfully created')
  end

  it "should list all new articles" do
    visit new_post_path
    time = Time.now.to_s
    fill_in 'Title', :with => 'test post'
    fill_in 'Content', :with => time
    click_button('Create')
    page.should have_content(time)
  end
end

describe Post, "that have some information missing" do
  before(:all) do
    @user = Factory(:user)
    @post = Factory(:post, :user => @user)
    login_as @user
  end

  after(:all) do
    log_out
  end
  it "should not create post and display error if title is missing" do
    visit new_post_path
    fill_in 'Content', :with => 'test content'
    click_button('Create')
    page.should have_content('Title is required to create a post')
  end

  it "should not create post and display error if content is missing" do
    visit new_post_path
    fill_in 'Content', :with => 'test content'
    click_button('Create')
    page.should have_content('Content is required to create a post')
  end
end

