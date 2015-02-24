class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.text :todo_item
	  t.string :todo_for
      t.date :todo_deadline
	  t.string :todo_category
	  t.string :todo_project
      t.integer :todo_importance
      t.integer :todo_urgence
      t.decimal :todo_timerequired
      t.boolean :todo_recurring
      t.string :todo_frequency
      t.decimal :todo_status
      t.decimal :todo_timeremaining
      t.integer :todo_ranking
	  t.boolean :todo_complete
	  t.date :todo_enddate
	  t.time :todo_deadlinetime
	  t.string :todo_review
      t.timestamps null: false
    end
  end
end
