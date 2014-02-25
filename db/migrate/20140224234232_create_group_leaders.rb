class CreateGroupLeaders < ActiveRecord::Migration
  def change
    create_table :group_leaders do |t|
      t.references :user, index: true
      t.references :lifegroup, index: true

      t.timestamps
    end
  end
end
