# spec/features/add_food_view_spec.rb

require 'rails_helper'

RSpec.feature 'Add Food view', type: :feature do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }

  before do
    sign_in user
    visit new_food_path
  end

  scenario "User sees the 'Add a new food' section" do
    expect(page).to have_css('.food-container')
    expect(page).to have_css('.header', text: 'Add a new food')
    expect(page).to have_css('form')
  end

  scenario 'User fills in the form to add a new food' do
    fill_in 'Name', with: 'Apple'
    fill_in 'Measurement unit', with: 'Piece'
    fill_in 'Price', with: '1.99'
    fill_in 'Quantity', with: '10'

    click_button 'Save'

    expect(page).to have_content('Apple was successfully added to you store')
    expect(page).to have_content('Apple')
    expect(page).to have_content('Piece')
    expect(page).to have_content('$1.99')
  end
end
