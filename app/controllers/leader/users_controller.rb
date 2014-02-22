module Leader
  class UsersController < ApplicationController

    def finish_signup
      @user = current_user
    end

    def update_signup_attributes
      if current_user.update(user_params)
        finalize_signup
      else
        error_finishing_signup
      end
    end

    private

    def user_params
      params.require(:user).permit(:display_name, :email)
    end

    def finalize_signup
      current_user.send_welcome_email
      flash[:success] = current_user.finalized_signup_message
      redirect_to leader_dashboard_path(:nickname => current_user.nickname)
    end

    def error_finishing_signup
      flash[:error] = "OOPS! Looks like something went wrong."
      render :finish_signup
    end

  end
end
