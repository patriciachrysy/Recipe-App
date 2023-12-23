require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }
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
  let(:food) do
    Food.create(
      name: 'Apple',
      measurement_unit: 'Grams',
      price: 1.99,
      quantity: 10,
      user:
    )
  end
  let(:valid_attributes) { { food_id: food.id, quantity: 2 } }
  let(:invalid_attributes) { { food_id: nil, quantity: -1 } }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { recipe_id: recipe.id }
      expect(response).to be_successful
      expect(assigns(:recipe_food)).to be_a_new(RecipeFood)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new RecipeFood' do
        expect do
          post :create, params: { recipe_id: recipe.id, recipe_food: valid_attributes }
        end.to change(RecipeFood, :count).by(1)

        expect(response).to redirect_to(recipe_path(recipe))
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        post :create, params: { recipe_id: recipe.id, recipe_food: invalid_attributes }
        expect(response).to render_template('new')
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'GET #edit' do
    let(:recipe_food) { RecipeFood.create(quantity: 2, recipe:, food:) }

    it 'returns a success response' do
      get :edit, params: { recipe_id: recipe.id, id: recipe_food.to_param }
      expect(response).to be_successful
      expect(assigns(:recipe_food)).to eq(recipe_food)
    end
  end

  describe 'PUT #update' do
    let(:recipe_food) { RecipeFood.create(quantity: 2, recipe:, food:) }

    context 'with valid params' do
      let(:new_attributes) { { quantity: 3 } }

      it 'updates the requested recipe_food' do
        put :update, params: { recipe_id: recipe.id, id: recipe_food.to_param, recipe_food: new_attributes }
        recipe_food.reload
        expect(recipe_food.quantity).to eq(new_attributes[:quantity])
        expect(response).to redirect_to(recipe_path(recipe_food.recipe))
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        put :update, params: { recipe_id: recipe.id, id: recipe_food.to_param, recipe_food: invalid_attributes }
        expect(response).to render_template('edit')
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:recipe_food) { RecipeFood.create(quantity: 2, recipe:, food:) }

    it 'destroys the requested recipe_food' do
      expect do
        delete :destroy, params: { recipe_id: recipe.id, id: recipe_food.to_param }
      end.to change(RecipeFood, :count).by(-1)

      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to be_present
    end
  end

  describe 'GET #generate_shopping_list' do
    it 'returns a success response' do
      get :generate_shopping_list
      expect(response).to be_successful
    end
  end
end
