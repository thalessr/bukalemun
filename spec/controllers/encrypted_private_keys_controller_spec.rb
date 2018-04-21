require 'rails_helper'

RSpec.describe EncryptedPrivateKeysController, type: :controller do

  let(:user) { create(:user) }

  before do
    user.sign_in(request)
    request.headers.merge!({'Authorization' => user.auth_token})
  end

  describe 'POST #create' do
    let(:encrypted_private_key) { attributes_for(:encrypted_private_key, key: key) }

    context 'When a encrypted_private_key is created' do
      let(:key) { 'Latitude 54' }

      it 'Returns the new encrypted_private_key json' do
        post :create, params: { encrypted_private_key: encrypted_private_key }
        encrypted_private_key_response = JSON.parse(response.body, symbolize_names: true)
        expect(encrypted_private_key_response[:encrypted_private_keyname]).to eq encrypted_private_key[:encrypted_private_keyname]
      end
      it 'Returns the created http code 201' do
        post :create, params: { encrypted_private_key: encrypted_private_key }
        is_expected.to respond_with 201
      end
    end
    context 'When encrypted_private_key is not created' do
      let(:key) { nil }

      it 'Returns a error' do
        post :create, params: { encrypted_private_key: encrypted_private_key }
        encrypted_private_key_response = JSON.parse(response.body, symbolize_names: true)
        expect(encrypted_private_key_response).to have_key(:errors)
      end
      it 'Returns unprocessable Entity http code 422' do
        post :create, params: { encrypted_private_key: encrypted_private_key }
        is_expected.to respond_with 422
      end
    end
  end

end
