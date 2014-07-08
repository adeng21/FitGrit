require 'rails_helper'

feature 'user registration', %Q{
    As an unauthenticated user
    I want to sign up
    So I can contribute to the site
  } do

  before :each do
    @user = FactoryGirl.build(:user)
    visit root_path
    click_on 'Sign up'
  end

  scenario 'user provides valid information and signs up' do
    fill_in 'Email', with: @user.email
    fill_in 'First name', with: @user.first_name
    fill_in 'Last name', with: @user.last_name
    fill_in 'user_password', with: @user.password
    fill_in 'user_password_confirmation', with: @user.password

    within('form') do
      click_on 'Sign up'
    end

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(current_path).to eql(root_path)
  end

  scenario 'user provides invalid information' do
    fill_in 'Email', with: ""
    fill_in 'First name', with: ""
    fill_in 'Last name', with: ""
    fill_in 'user_password', with: ""
    fill_in 'user_password_confirmation', with: ""

    within('form') do
      click_on 'Sign up'
    end

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign out")
  end
end
