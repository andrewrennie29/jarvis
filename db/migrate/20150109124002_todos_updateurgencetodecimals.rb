class TodosUpdateurgencetodecimals < ActiveRecord::Migration
  def change
	change_column :todos, :todo_urgence, :decimal, :precision => 10, :scale => 4
  end
end
