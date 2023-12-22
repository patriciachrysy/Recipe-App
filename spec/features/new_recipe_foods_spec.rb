require 'rails_helper'

RSpec.feature 'RecipeFoods', type: :feature do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }
  let(:recipe) do
    Recipe.create(user:, name: 'Apple pie', preparation_time: 30, cooking_time: 15,
                  description: 'Very easy to prepare', public: true)
  end
  let(:food) do
    Food.create(
      name: 'Sweets',
      measurement_unit: 'Grams',
      price: 1.99,
      quantity: 10,
      user:
    )
  end
  let(:recipe_food) { RecipeFood.create(quantity: 10, recipe:, food:) }

  before do
    sign_in user
  end

  scenario 'User adds a new ingredient to a recipe' do
    visit edit_recipe_recipe_food_path(recipe, recipe_food)

    within('.food-container') do
      expect(page).to have_css('h2.header', text: "Modify ingredient \"#{recipe_food.food.name}\"")

      fill_in 'recipe_food_quantity', with: 3
      select food.name, from: 'recipe_food_food_id'

      click_button 'Save'
    end

    expect(page).to have_content('The ingredient was successfully updated')
    expect(page).to have_current_path(recipe_path(recipe))
  end
end
