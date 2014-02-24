class AddCompletedStepsToLifegroups < ActiveRecord::Migration
  def change
    add_column :lifegroups, :completed_steps, :text
  end
end
