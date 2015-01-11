class TodosUpdatedeadlines < ActiveRecord::Migration
  def change
add_column :todos, :todo_deadlinetime, :time
change_column :todos, :todo_deadline, :date
  end
end
