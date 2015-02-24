class AddAssignedDateandRecurLatest < ActiveRecord::Migration
  def change

    add_column :todos, :assigneddate, :date
    add_column :todos, :latestrecur, :boolean
    add_column :users, :startwork, :time
    add_column :users, :endwork, :time
    add_column :users, :lunchstart, :time
    add_column :users, :lunchlength, :decimal, :precision => 10, :scale => 4


  end
end
