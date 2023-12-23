require 'rails_helper'

RSpec.feature 'RecipeFoods', type: :feature do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }
  let(:user_two) { User.create(name: 'Jane Doe', email: 'testjane@example.com', password: 'password123') }
  let(:recipe) do
    Recipe.create(user:, name: 'Apple pie', preparation_time: 30, cooking_time: 15,
                  description: 'Very easy to prepare', public: true)
  end
  let(:food) do
    Food.create(name: 'Apple', measurement_unit: 'Grams', price: 1.99, quantity: 10, user:)
  end
  let(:recipe_food) { create(quantity: 10, recipe:, food:) }

  before do
    sign_in user
  end

  scenario 'User views shopping list' do
    visit general_shopping_list_path

    expect(page).to have_css('p', text: 'There is nothing to buy, you have everything you need.')
  end
end
