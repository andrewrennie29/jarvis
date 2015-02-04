class AddUsernametoTodos < ActiveRecord::Migration
  def change
	
	add_column :todos, :username, :string

  end
end
