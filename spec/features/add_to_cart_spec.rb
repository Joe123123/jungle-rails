# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User add product to cart', type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |_n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'They see the number increases by one in my cart' do
    # ACT
    visit root_path

    save_screenshot

    expect(page).to have_text 'My Cart (0)'

    page.all('footer form button').first.click

    # DEBUG / VERIFY
    save_screenshot

    expect(page).to have_text 'My Cart (1)'
  end
end
