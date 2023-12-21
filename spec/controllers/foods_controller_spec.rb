require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  let(:user) { User.create(name: 'Testor', email: 'test@example.com', password: 'password123') }
  let(:food_params) do
    {
      name: 'Apple',
      measurement_unit: 'Grams',
      price: 1.99,
      quantity: 10
    }
  end

  let(:food_update_params) do
    {
      name: 'Oranges',
      measurement_unit: 'Grams',
      price: 1.99,
      quantity: 10,
      user:
    }
  end

  before { sign_in user }

  describe 'GET #index' do
    it 'assigns @foods for the current user' do
      3.times do |_i|
        Food.create(
          name: 'Apple',
          measurement_unit: 'Grams',
          price: 1.99,
          quantity: 10,
          user:
        )
      end
      get :index
      expect(assigns(:foods)).to eq(Food.where(user:))
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Food to @food' do
      get :new
      expect(assigns(:food)).to be_a_new(Food)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it 'creates a new food' do
      expect do
        post :create, params: { food: food_params }
      end.to change(Food, :count).by(1)
    end

    it 'redirects to foods_path on successful creation' do
      post :create, params: { food: food_params }
      expect(response).to redirect_to(foods_path)
    end

    it 'renders new template on unsuccessful creation' do
      post :create, params: { food: { name: '', measurement_unit: 1 } }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested food to @food' do
      food = Food.create(food_update_params)
      get :edit, params: { id: food.id }
      expect(assigns(:food)).to eq(food)
    end

    it 'renders the edit template' do
      food = Food.create(food_update_params)
      get :edit, params: { id: food.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    it 'updates the food' do
      food = Food.create(food_update_params)
      updated_name = 'Updated Apple'
      patch :update, params: { id: food.id, food: { name: updated_name } }
      food.reload
      expect(food.name).to eq(updated_name)
    end

    it 'redirects to foods_path on successful update' do
      food = Food.create(food_update_params)
      patch :update, params: { id: food.id, food: { name: 'Updated Apple' } }
      expect(response).to redirect_to(foods_path)
    end

    it 'renders the edit template on unsuccessful update' do
      food = Food.create(food_update_params)
      patch :update, params: { id: food.id, food: { name: '' } }
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the food' do
      food = Food.create(food_update_params)
      expect do
        delete :destroy, params: { id: food.id }
      end.to change(Food, :count).by(-1)
    end

    it 'redirects to foods_path after destruction' do
      food = Food.create(food_update_params)
      delete :destroy, params: { id: food.id }
      expect(response).to redirect_to(foods_path)
    end
  end
end
