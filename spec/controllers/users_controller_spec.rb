# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    let(:user) { attributes_for(:user, username: username) }

    context 'When a user is created' do
      let(:username) { 'Garage 48' }

      it 'Returns the new user json' do
        post :create, params: { user: user }
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:username]).to eq user[:username]
      end
      it 'Returns the created http code 201' do
        post :create, params: { user: user }
        is_expected.to respond_with 201
      end
    end
    context 'When user is not created' do
      let(:username) { nil }

      it 'Returns a error' do
        post :create, params: { user: user }
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end
      it 'Returns unprocessable Entity http code 422' do
        post :create, params: { user: user }
        is_expected.to respond_with 422
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }

    def retrieve_user
      get :show, params: { username: user.username, format: :json }
    end

    it 'returns the information about a user on a hash' do
      retrieve_user
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:username]).to eq(user.username)
    end

    it do
      retrieve_user
      is_expected.to respond_with 302
    end
  end
end
