require 'rails_helper'

feature 'user sign out', %Q{
  As an authenticated user
  I want to sign out
  So I can exit the site properly
} do

  scenario 'user signs out' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    within('form') do
      click_on 'Sign in'
    end
    click_on 'Sign Out'

    expect(current_path).to eql(root_path)
    expect(page).to have_content("Signed out successfully")
  end
end
