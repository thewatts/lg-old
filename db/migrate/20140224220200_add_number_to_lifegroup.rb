class AddNumberToLifegroup < ActiveRecord::Migration
  def change
    add_column :lifegroups, :number, :string
  end
end
