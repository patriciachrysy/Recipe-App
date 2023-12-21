# spec/features/update_food_view_spec.rb

require 'rails_helper'

RSpec.feature 'Update Food view', type: :feature do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }
  let!(:food) { Food.create(name: 'Apple', measurement_unit: 'Piece', price: 1.99, quantity: 10, user:) }

  before do
    sign_in user
    visit edit_food_path(food)
  end

  scenario "User sees the 'Update food' section" do
    expect(page).to have_css('.food-container')
    expect(page).to have_css('.header', text: "Update #{food.name} food")
    expect(page).to have_css('form')
  end

  scenario 'User updates the food details' do
    fill_in 'Name', with: 'Updated Apple'
    fill_in 'Measurement unit', with: 'Kg'
    fill_in 'Price', with: '2.49'
    fill_in 'Quantity', with: '15'

    click_button 'Save'

    expect(page).to have_content('The food was successfully updated')
    expect(page).to have_content('Updated Apple')
    expect(page).to have_content('Kg')
    expect(page).to have_content('$2.49')
  end
end
