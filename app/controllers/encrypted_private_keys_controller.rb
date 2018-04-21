class EncryptedPrivateKeysController < ApplicationController
  before_action :require_authentication!

  def index
    render json: current_user.encrypted_private_key, status: :ok
  end

  def create
    encrypted_private_key = current_user.build_encrypted_private_key(encrypted_private_key_params)
    if encrypted_private_key.save
      render json: encrypted_private_key, status: :created
    else
      render json: { errors: encrypted_private_key.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def encrypted_private_key_params
    params.require(:encrypted_private_key).permit(:key)
  end
end
