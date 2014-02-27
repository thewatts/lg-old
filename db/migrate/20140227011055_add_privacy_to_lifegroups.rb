class AddPrivacyToLifegroups < ActiveRecord::Migration
  def change
    add_column :lifegroups, :privacy, :string, :default => "open"
  end
end
