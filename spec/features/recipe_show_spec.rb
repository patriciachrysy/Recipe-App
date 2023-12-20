require 'rails_helper'

RSpec.feature 'Recipe Show Page' do
  let!(:user1) do
    User.create(name: 'John Doe', photo: 'https://john-doe-picture', email: 'john@doe.com', password: 'johndoe123')
  end
  let!(:recipe1) do
    Recipe.create(user_id: user1, name: 'Pizza', preparation_time: 30, cooking_time: 15, description: 'Very easy to prepare', steps: 'Prepare dough. Add a sauce and tomato. Bake 10 min.',
               public: true, photo: File.open(Rails.root.join('public/uploads', 'pizza_image.jpeg')))
  end

  scenario 'Displays recipe name' do
    visit recipe_path(recipe1)
    expect(page).to have_content(recipe1.name)
  end

  scenario 'Displays recipe preparation and cooking time' do
    visit recipe_path(recipe1)
    expect(page).to have_content(recipe1.preparation_time)
    expect(page).to have_content(recipe1.cooking_time)
  end

  scenario 'Displays recipe steps' do
    visit recipe_path(recipe1)
    expect(page).to have_content(recipe1.steps)
  end
end
