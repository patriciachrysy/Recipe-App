require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }

  it 'is valid with valid attributes' do
    food = Food.new(
      name: 'Apple',
      measurement_unit: 'Grams',
      price: 1.99,
      quantity: 10,
      user:
    )
    expect(food).to be_valid
  end

  it 'is not valid without a name' do
    food = Food.new(
      measurement_unit: 'Grams',
      price: 1.99,
      quantity: 10,
      user:
    )
    expect(food).not_to be_valid
  end

  it 'is not valid without a measurement unit' do
    food = Food.new(
      name: 'Apple',
      price: 1.99,
      quantity: 10,
      user:
    )
    expect(food).not_to be_valid
  end

  it 'is not valid without a valid price' do
    food = Food.new(
      name: 'Apple',
      measurement_unit: 'Grams',
      quantity: 10,
      user:
    )
    expect(food).not_to be_valid
  end

  it 'is not valid without a quantity' do
    food = Food.new(
      name: 'Apple',
      measurement_unit: 'Grams',
      price: 1.99,
      user:
    )
    expect(food).not_to be_valid
  end

  it 'belongs to a user' do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end
end
