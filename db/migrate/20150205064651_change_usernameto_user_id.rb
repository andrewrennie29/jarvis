class ChangeUsernametoUserId < ActiveRecord::Migration
  def change
	change_column :todos, :username, :int
	rename_column :todos, :username, :user_id
  end
end
