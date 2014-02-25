class SessionsController < ApplicationController
  respond_to :json, :only => [:create]

  def create
    user = User.from_omniauth(auth_hash) if auth_hash
    user ? log_in(user) : error_logging_in(user)
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def log_in(user)
    session[:user_id] = user.id
    send_to_dashboard(user)
  end

  def error_logging_in(user)
    flash[:error] = logging_in_error_message
    redirect_to leader_signup_path
  end

  def logging_in_error_message
    "Sorry! Looks like there was an issue. Please try again or contact support."
  end

end
