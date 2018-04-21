# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:user) { create(:user) }

  describe 'POST #create - new session' do

    context 'When a api client provides a correct login' do
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
    context 'When a api client provides an incorrect login' do
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

  context 'DELETE #destroy' do

    context 'When a client has a valid session' do
      before(:each) do
        user.sign_in(request)
        request.headers.merge!({'Authorization' => user.auth_token})
        delete :destroy, params: { id: user.auth_token }
      end

      it { should respond_with 204 }
    end
    # context 'When a client has an invalid session' do
    #   before(:each) do
    #     request.headers.merge!({'Authorization' => nil})
    #     delete :destroy, params: { id: user.id }
    #   end
    #
    #   it 'returns a json with an error' do
    #     json_response = JSON.parse(response.body, symbolize_names: true)
    #     expect(json_response[:errors]).to eq('Not authorized!')
    #   end
    #
    #   it { should respond_with 401 }
    # end
  end
end
