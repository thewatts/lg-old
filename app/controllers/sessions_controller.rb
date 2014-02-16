class SessionsController < ApplicationController
  respond_to :json, :only => [:create]

  def create
    user = User.from_omniauth(auth_hash) if auth_hash
    if user
      session[:user_id] = user.id
      flash[:success] = logged_in_message_for(user)
      redirect_to leader_dashboard_path(:nickname => user.nickname)
    else
      flash[:error] = logging_in_error_message
      redirect_to leader_signup_path
    end
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end

  def logging_in_error_message
    "Sorry! Looks like there was an issue. Please try again or contact support."
  end

  def logged_in_message_for(user)
    "Congrats, #{user.full_name}!, You're successfully logged in!"
  end
end
