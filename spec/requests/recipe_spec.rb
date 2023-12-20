require 'rails_helper'

RSpec.describe RecipesController, type: :request do
  describe 'GET /index' do
    let(:user) { create(:user) }

    it 'returns a successful response' do
      get '/recipes'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/recipes'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get '/recipes'
      expect(response.body).to match('Recipes')
    end
  end

  describe 'GET /show' do
    let(:user) { create(:user) }

    it 'returns a successful response' do
      get '/recipes/:id'
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get '/recipes/:id'
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get '/recipes/:id'
      expect(response.body).to match('Cooking')
    end
  end
end
