class Leader::GroupSteps::BasicsController < ApplicationController

  def edit
    @basics = basics_for_current_group
  end

  def update
    @basics = basics_for_current_group
    if @basics.update(basics_params)
      flash[:success] = "#{current_group.name}'s basic information saved."
      redirect_to group_edit_leadership_path
    else
      flash[:error] = "Oops! Something went wrong."
      render :edit
    end
  end

  private

  def basics_for_current_group
    Basics.new(current_group) if current_group
  end

  def basics_params
    params.require(:basics).permit(
      :description,
      :name,
      :semester_id,
      :privacy
    )
  end

  def group_edit_leadership_path
    leader_group_steps_edit_leadership_path(
      :nickname => current_user.nickname,
      :group_number => current_group.number
    )
  end
end
