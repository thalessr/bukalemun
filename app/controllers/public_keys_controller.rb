# frozen_string_literal: true

class PublicKeysController < ApplicationController

  before_action :require_authentication!

  def index
    render json: current_user.public_key, status: :ok
  end

  def create
    public_key = current_user.build_public_key(public_key_params)
    if public_key.save
      render json: public_key, status: :created
    else
      render json: { errors: public_key.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def public_key_params
    params.require(:public_key).permit(:key)
  end

end
