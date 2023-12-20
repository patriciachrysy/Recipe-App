require 'rails_helper'

RSpec.feature 'Recipe Index Page' do
  let!(:user1) do
    User.create(name: 'John Doe', photo: File.open(Rails.root.join('public/uploads', 'pizza_image.jpeg')), email: 'john@doe.com', password: 'johndoe123')
  end
  let!(:recipe1) do
    Recipe.create(user_id: user1, name: 'Pizza', preparation_time: 30, cooking_time: 15, description: 'Very easy to prepare', steps: 'Prepare dough. Add a sauce and tomato. Bake 10 min.',
               public: true, photo: File.open(Rails.root.join('public/uploads', 'pizza_image.jpeg')))
  end

  scenario 'Displays recipe picture, name, description' do
    visit recipes_path
    expect(page).to have_css("img[src*='#{recipe1.photo.url}']")
    expect(page).to have_content(recipe1.name)
    expect(page).to have_content(recipe1.description)
  end

  scenario 'Redirects to recipe show page when clicked' do
    visit recipes_path
    click_link recipe1.name
    sleep(2)
    expect(current_path).to eq(recipe_path(recipe1))
  end
end
