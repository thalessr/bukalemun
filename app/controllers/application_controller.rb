# frozen_string_literal: true

class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user, :require_authentication

  protected

  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def require_authentication
    return fail if current_user.blank?
  end

end
