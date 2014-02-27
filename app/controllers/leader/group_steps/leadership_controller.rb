class Leader::GroupSteps::LeadershipController < ApplicationController
  def edit
    @leadership = leadership_for_current_group
  end

  def update
    @leadership = leadership_for_current_group
    if @leadership.update(leadership_params)
      flash[:success] = "#{current_group.name}'s leadership information saved."
      redirect_to group_edit_meeting_details_path
    else
      flash[:error] = "Oops! Something went wrong."
      render :edit
    end
  end

  private

  def leadership_params
    params.require(:leadership).permit(
      :leader_ids => []
    )
  end

  def leadership_for_current_group
    Leadership.new(current_group)
  end

  def group_edit_meeting_details_path
    leader_group_steps_edit_meeting_details_path
  end
end
