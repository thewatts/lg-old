class CreateLifegroups < ActiveRecord::Migration
  def change
    create_table :lifegroups do |t|

      t.timestamps
    end
  end
end
