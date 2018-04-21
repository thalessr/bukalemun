# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do # rubocop:disable BlockLength
  let(:user) { create(:user) }

  describe 'POST #create - new session' do
    context 'when a api client provides a correct login' do
      before do
        login_attributes = { username: user.username, password: user.password }
        post :create, params: { session: login_attributes }
      end
      it 'Return a token' do
        user.reload
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:auth_token]).to eq user.auth_token
      end
      it { is_expected.to respond_with 200 }
    end
    context 'when a api client provides an incorrect login' do
      before do
        login_attributes = { username: user.username, password: 'Viru' }
        post :create, params: { session: login_attributes }
      end
      it 'returns a json with an error' do
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:errors]).to eq('Username/Password mismatch')
      end
      it { is_expected.to respond_with 401 }
    end
  end

  describe 'DELETE #destroy' do
    context 'when a client has a valid session' do
      before do
        user.sign_in(request)
        request.headers['Authorization'] = user.auth_token
        delete :destroy
      end

      it { is_expected.to respond_with 204 }
    end
    context 'when a client has an invalid session' do
      before do
        request.headers['Authorization'] = nil
        delete :destroy
      end

      it 'returns a json with an error' do
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:errors]).to eq('Access denied')
      end

      it { is_expected.to respond_with 401 }
    end
  end
end
