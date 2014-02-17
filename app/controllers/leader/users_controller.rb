module Leader
  class UsersController < ApplicationController

    def finish_signup
      @user = current_user
    end

    def update_signup_attributes
      if current_user.update(user_params)
        flash[:success] = "You're officially signed up, #{current_user.name}!"
        redirect_to leader_dashboard_path(:nickname => current_user.nickname)
      else
        flash[:error] = "OOPS! Looks like something went wrong."
        render :finish_signup
      end
    end

    private
    def user_params
      params.require(:user).permit(:email)
    end

  end
end
