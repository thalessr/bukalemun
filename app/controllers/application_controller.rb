# frozen_string_literal: true

class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user

  protected

  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def require_authentication!
    return true if current_user.present?
    render json: { errors: 'Access denied' }, status: 401
  end


end
