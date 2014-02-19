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

  def error_logging_in(user)
    flash[:error] = logging_in_error_message
    redirect_to leader_signup_path
  end

  def log_in(user)
    session[:user_id] = user.id
    user.complete? ? send_to_dashboard(user) : send_to_finish_signup(user)
  end

  def send_to_dashboard(user)
    flash[:success] = logged_in_message_for(user)
    redirect_to leader_dashboard_path(:nickname => user.nickname)
  end

  def send_to_finish_signup(user)
    flash[:success] = signed_up_message_for(user)
    redirect_to leader_finish_signup_path(:nickname => user.nickname)
  end

  def signed_up_message_for(user)
    "Thanks for signing up, #{user.name}!"
  end

  def logged_in_message_for(user)
    "Congrats, #{user.name}, You've successfully logged in!"
  end

  def logging_in_error_message
    "Sorry! Looks like there was an issue. Please try again or contact support."
  end


end
