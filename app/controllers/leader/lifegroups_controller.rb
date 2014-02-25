module Leader
  class LifegroupsController < ApplicationController

    def index
    end

    def new
      @lifegroup = Lifegroup.new
    end

    def create
      @lifegroup = current_user.lifegroups.create(lifegroup_params)
      if @lifegroup.valid?
        flash[:success] = "#{@lifegroup.name}'s basic information saved."
        redirect_to leader_group_steps_edit_specifics_path(
          :nickname => current_user.nickname,
          :group_number => @lifegroup.number
        )
      else
        flash[:error] = "Oops! Something went wrong."
        render :new
      end
    end

  private
    def lifegroup_params
      params.require(:lifegroup).permit(
        :description,
        :name,
        :semester_id,
        :leader_ids => [], # explicity tell strong params this is an array
      )
    end
  end
end
