class ChangeLoginToNicknameOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :login, :nickname
  end
end
