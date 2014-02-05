class AddDescriptionToLifegroups < ActiveRecord::Migration
  def change
    add_column :lifegroups, :description, :text
  end
end
