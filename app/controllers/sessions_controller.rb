class SessionsController < ApplicationController
  before_action :require_authentication, except: :create

  def create
    user = User.find_by(username: session_params[:username])

    return render_error if user.blank?

    if user.authenticate(session_params[:password])
      user.sign_in(request)
      render json: { auth_token: user.auth_token }, status: :ok
    else
      render_error
    end
  end

  def destroy
    current_user.sign_out
    render json: {}, status: :no_content
  end

  private

  def render_error
    render json: {errors: 'Username/Password mismatch'}, status: :unauthorized
  end

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
