require 'spec_helper'

feature 'Sign Up' do
  before :each do
    visit '/users/new'
  end

  it 'has a user sign up page' do
    page.should have_content 'Register'
  end

  it 'takes a mandatory email and password' do
    page.should have_content 'Email'
    page.should have_content 'Password'
  end

  it 'takes a username' do
    page.should have_content 'Username'
    page.should_not have_content 'Username*'
  end

  it "validates the presence of the user's email" do
    click_button 'Register'
    page.should have_content 'Register'
    page.should have_content "Email can't be blank"
  end

  it "validates the presence of the user's password" # do
#     fill_in 'Email', with: 'email@example.com'
#     click_button 'Register'
#     page.should have_content 'Register'
#     page.should have_content "Password can't be blank"
#   end

  it "validates that the password is at least 6 characters long" do
    fill_in "Email", with: 'email@example.com'
    fill_in "Password", with: 'short'
    click_button 'Register'
    page.should have_content 'Register'
    page.should have_content 'Password is too short'
  end

  # it "validates taht the password contains only alphanumeric characters" do
 #    fill_in "Email", with: 'email@example.com'
 #    fill_in "Password", with: 'symbols_'
 #    click_button 'Sign Up'
 #    page.should have_content 'Sign Up'
 #    page.should have_content 'Password is too short'
 #  end

 it "logs the user in and redirects them to the home page on success" do
   sign_up_as_example_user
   # add user name to application.html.erb layout
   page.should have_content 'Welcome, Guest'
   page.should have_content 'KrishList : New York City'
 end
end


feature "Sign out" do
  it "has a sign out button" do
    sign_up_as_example_user
    page.should have_button 'Sign Out'
  end

  # it "logs a user out on click and checks that its not allowed access to links index" do
  #   sign_up_as_hello_world
  #
  #   click_button 'Sign Out'
  #   visit '/links'
  #
  #   # redirect to login page
  #   page.should have_content 'Sign In'
  #   page.should have_content "Username"
  # end
end

feature "Sign in" do
  it "has a sign in page" do
    visit "/session/new"
    page.should have_content "Sign In"
  end

  it "takes an email and password" do
    visit "/session/new"
    page.should have_content "Email"
    page.should have_content "Password"
  end

  it "returns to sign in on failure" do
    visit "/session/new"
    fill_in "Email", with: 'example_user'
    fill_in "Password", with: 'example'
    click_button "Sign In"

    # return to sign-in page
    page.should have_content "Sign In"
    page.should have_content "Email"
  end

  # it "takes a user to links index on success" do
  #   sign_up_as_hello_world
  #   # add button to sign out in application.html.erb layout
  #   click_button 'Sign Out'
  #
  #   # Sign in as newly created user
  #   visit "/session/new"
  #   fill_in "Username", with: 'hello_world'
  #   fill_in "Password", with: 'abcdef'
  #   click_button "Sign In"
  #   page.should have_content "hello_world"
  # end
end