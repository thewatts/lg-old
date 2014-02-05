class AddSemesterToLifegroups < ActiveRecord::Migration
  def change
    add_reference :lifegroups, :semester, index: true
  end
end
