module Leader
  class LifegroupsController < ApplicationController

    def index
    end

    def new
      @lifegroup = Lifegroup.new
    end

    def create
      @lifegroup = Lifegroup.new(lifegroup_params)
      if @lifegroup.save
        flash[:success] = "Thanks for submitting #{@lifegroup.name} for approval!"
        redirect_to leader_lifegroups_path
      else
        flash[:error] = "Oops! Something went wrong."
        render :new
      end
    end

    private
    def lifegroup_params
      params.require(:lifegroup).permit(
        :name,
        :semester_id,
        :description
      )
    end
  end
end
