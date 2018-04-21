# frozen_string_literal: true

class UsersController < ApplicationController

  def index
    render json: User.all.order(:username)
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    user = User.find_by(username: params[:username])
    if user.present?
      render json: user, status: :found
    else
      render json: { error: { errors: 'User not found' } }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name)
  end

end
