require 'rails_helper'

RSpec.describe PublicKeysController, type: :controller do

  let(:user) { create(:user) }

  before do
    user.sign_in(request)
    request.headers.merge!({'Authorization' => user.auth_token})
  end

  describe 'POST #create' do
    let(:public_key) { attributes_for(:public_key, key: key) }

    context 'When a public_key is created' do
      let(:key) { 'Latitue 54' }

      it 'Returns the new public_key json' do
        post :create, params: { public_key: public_key }
        public_key_response = JSON.parse(response.body, symbolize_names: true)
        expect(public_key_response[:public_keyname]).to eq public_key[:public_keyname]
      end
      it 'Returns the created http code 201' do
        post :create, params: { public_key: public_key }
        is_expected.to respond_with 201
      end
    end
    context 'When public_key is not created' do
      let(:key) { nil }

      it 'Returns a error' do
        post :create, params: { public_key: public_key }
        public_key_response = JSON.parse(response.body, symbolize_names: true)
        expect(public_key_response).to have_key(:errors)
      end
      it 'Returns unprocessable Entity http code 422' do
        post :create, params: { public_key: public_key }
        is_expected.to respond_with 422
      end
    end
  end

end
