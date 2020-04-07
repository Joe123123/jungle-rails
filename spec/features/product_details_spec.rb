# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'ProductDetails', type: :feature, js: true do
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

  scenario 'They see detail of that product' do
    # ACT
    visit root_path

    page.all('.btn.btn-default.pull-right').first.click

    # DEBUG / VERIFY
    save_screenshot

    expect(page).to have_css '.products-show', count: 1
  end
end
