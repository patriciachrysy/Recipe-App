require 'rails_helper'

RSpec.feature 'User Index Page' do
  let!(:user1) do
    User.create(name: 'John Doe', photo: 'https://john-doe-picture', email: 'john@doe.com', password: 'johndoe123')
  end
  let!(:recipe1) do
    Recipe.create(user: user1, name: 'Pizza', preparation_time: 30, cooking_time: 15, description: 'Very easy to prepare',
                  public: true, photo: File.open(Rails.root.join('public/uploads', 'pizza_image.jpeg')))
  end

  before do
    sign_in user1
  end

  scenario 'Displays user picture, name' do
    visit users_path
    expect(page).to have_css("img[src*='#{user1.photo}']")
    expect(page).to have_content(user1.name)
  end

  scenario 'Displays recipes count' do
    visit users_path
    expect(page).to have_content("Number of recipes: #{user1.recipes.count}")
  end
end
