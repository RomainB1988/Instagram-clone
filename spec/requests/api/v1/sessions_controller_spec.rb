require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  let(:user) { create(:user, email: 'test12345@example.com', password: 'password') }

  describe 'POST /api/v1/users/sign_in' do
    context 'with valid credentials' do
      it 'authenticates the user and returns a success message' do
        post '/api/v1/users/sign_in', params: { email: user.email, password: user.password }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['authentication_token']).not_to be_nil
      end
    end

    context 'with invalid credentials' do
      it 'returns an error message' do
        post '/api/v1/users/sign_in', params: { email: user.email, password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Unauthorized')
      end
    end
  end

  describe 'DELETE /api/v1/users/sign_out' do
    context 'when user is logged in' do
      it 'logs out the user and returns a success message' do
        delete '/api/v1/users/sign_out', headers: { Authorization: "Token token=#{user.authentication_token}" }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when user is not logged in' do
      it 'returns an unauthorized message' do
        delete '/api/v1/users/sign_out'
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Non autorisé ou déjà déconnecté')
      end
    end
  end
end
