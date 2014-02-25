class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def send_to_dashboard(user)
    if user.complete?
      flash[:success] = user.logged_in_message
      redirect_to leader_dashboard_path(:nickname => user.nickname)
    else
      flash[:success] = user.initial_signup_message
      redirect_to leader_finish_signup_path
    end
  end

end
