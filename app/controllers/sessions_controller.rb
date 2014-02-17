class SessionsController < ApplicationController
  respond_to :json, :only => [:create]

  def create
    user = User.from_omniauth(auth_hash) if auth_hash
    if user
      log_in_user(user)
    else
      flash[:error] = logging_in_error_message
      redirect_to leader_signup_path
    end
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end

  def log_in_user(user)
    session[:user_id] = user.id
    if user.complete?
      flash[:success] = logged_in_message_for(user)
      redirect_to leader_dashboard_path(:nickname => user.nickname)
    else
      flash[:success] = signed_up_message_for(user)
      redirect_to leader_finish_signup_path(:nickname => user.nickname)
    end
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
