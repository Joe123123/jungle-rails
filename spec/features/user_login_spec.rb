# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User Logins', type: :feature, js: true do
  # SETUP
  before :each do
    User.create!(first_name: 'lorem',
                 last_name: 'ipsum',
                 email: 'test@email.com',
                 password: 'pw1234',
                 password_confirmation: 'pw1234')
  end

  scenario 'they see their email and a logout button in top nav bar' do
    visit root_path

    click_on 'Login'

    fill_in 'Email', with: 'test@email.com'

    fill_in 'Password', with: 'pw1234'

    click_button 'Login'

    save_screenshot

    expect(page).to have_text 'test@email.com'
    expect(page).to have_text 'Logout'
  end
end
