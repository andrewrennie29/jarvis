class ChangeDeadlineType < ActiveRecord::Migration
  def change
    change_column :todos, :todo_deadline, :datetime
  end
end
