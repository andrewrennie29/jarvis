class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.text :todo_item
      t.string :todo_for
      t.datetime :todo_deadline
      t.integer :todo_importance
      t.integer :todo_urgence
      t.decimal :todo_timerequired
      t.boolean :todo_recurring
      t.string :todo_frequency
      t.decimal :todo_status
      t.decimal :todo_timeremaining
      t.integer :todo_ranking
      t.boolean :todo_complete

      t.timestamps null: false
    end
  end
end
