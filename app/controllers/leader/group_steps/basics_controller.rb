class Leader::GroupSteps::BasicsController < ApplicationController

  def edit
    group = current_user.lifegroups.find_by(:number => params[:group_number])
    @basics = Basics.new(group)
  end

  def update
    group = current_user.lifegroups.find_by(:number => params[:group_number])
    @basics = Basics.new(group)
    if @basics.update(basics_params)
      flash[:success] = "#{group.name}'s basic information saved."
      redirect_to leader_group_steps_edit_specifics_path(
        :nickname => current_user.nickname,
        :group_number => group.number
      )
    else
      flash[:error] = "Oops! Something went wrong."
      render :edit
    end
  end

  def basics_params
    params.require(:basics).permit(
      :description,
      :name,
      :semester_id,
    )
  end
end
