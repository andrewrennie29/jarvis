class Fixdecimalcolumns < ActiveRecord::Migration
  def change

	change_column :todos, :todo_timerequired, :decimal, :precision => 10, :scale => 4
	change_column :todos, :todo_timeremaining, :decimal, :precision => 10, :scale => 4
	change_column :todos, :todo_status, :decimal, :precision => 10, :scale => 4
	change_column :todos, :todo_ranking, :decimal, :precision => 10, :scale => 4
  end
end
