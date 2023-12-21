require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    let(:user) { User.create(name: 'Testor', email: 'test@example.com', password: 'password123') }
    before { sign_in user }

    it 'returns a successful response' do
      get '/'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get '/'
      expect(response.body).to match('Number of recipes')
    end
  end
end
