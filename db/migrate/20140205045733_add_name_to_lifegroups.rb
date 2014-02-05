class AddNameToLifegroups < ActiveRecord::Migration
  def change
    add_column :lifegroups, :name, :string
  end
end
