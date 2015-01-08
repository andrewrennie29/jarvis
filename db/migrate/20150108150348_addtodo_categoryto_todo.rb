class AddtodoCategorytoTodo < ActiveRecord::Migration
  def change
  
    add_column :todos, :todo_enddate, :date

  end
end
