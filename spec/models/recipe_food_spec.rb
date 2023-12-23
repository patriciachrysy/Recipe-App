require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }
  let(:user_two) { User.create(name: 'Jane Doe', email: 'testjane@example.com', password: 'password123') }
  let(:food) do
    Food.create(
      name: 'Apple',
      measurement_unit: 'Grams',
      price: 1.99,
      quantity: 10,
      user:
    )
  end
  let(:food_two) do
    Food.create(
      name: 'Sugar',
      measurement_unit: 'Grams',
      price: 0.5,
      quantity: 2.8,
      user: user_two
    )
  end
  let(:recipe) do
    Recipe.create(
      user:,
      name: 'Apple pie',
      preparation_time: 30,
      cooking_time: 15,
      description: 'Very easy to prepare',
      public: true
    )
  end

  it 'is valid with valid attributes' do
    recipe_food = RecipeFood.new(
      recipe:,
      food:,
      quantity: 10
    )
    expect(recipe_food).to be_valid
  end

  it 'is not valid without a quantity' do
    recipe_food = RecipeFood.new(
      recipe:,
      food:
    )
    expect(recipe_food).not_to be_valid
  end

  it 'returns the list of missing food for the user\'s recipes' do
    RecipeFood.create(
      recipe:,
      food:,
      quantity: 10
    )
    recipe_food = RecipeFood.create(
      recipe:,
      food: food_two,
      quantity: 10
    )
    missing_food = RecipeFood.missing_food(user.id)

    expect(missing_food).to include(recipe_food)
    expect(missing_food.length).not_to eq(0)
  end

  it 'belongs to a recipe' do
    association = described_class.reflect_on_association(:recipe)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'belongs to a food' do
    association = described_class.reflect_on_association(:food)
    expect(association.macro).to eq(:belongs_to)
  end
end
