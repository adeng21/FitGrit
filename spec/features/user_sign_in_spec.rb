require 'rails_helper'

feature 'user logs in', %Q{
  As an unauthenticated user
  I want to sign into my account
  So I can track my previous workouts and make new ones
} do

before :each do
  @user = FactoryGirl.create(:user)
  visit root_path
  click_on "Sign In"
end

  scenario 'user provides correct login information' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    within('form') do
      click_on 'Sign in'
    end

    expect(page).to have_content("Welcome back #{@user.first_name}!")
    expect(current_path).to eql(root_path)
  end

  scenario 'user provides incorrect email' do
    fill_in 'Email', with: 'garbage@garbage.com'
    fill_in 'Password', with: @user.password

    within('form') do
      click_button 'Sign in'
    end

    expect(page).to have_content("Invalid email or password.")
    expect(page).to_not have_content("Welcome back #{@user.first_name}!")
  end

  scenario 'user provides incorrect password' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'passwordfoo'
    within('form') do
      click_button 'Sign in'
    end

    expect(page).to have_content("Invalid email or password.")
    expect(page).to_not have_content('Welcome back #{@user.first_name}!')
  end
end
