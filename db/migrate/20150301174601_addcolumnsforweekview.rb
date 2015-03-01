class Addcolumnsforweekview < ActiveRecord::Migration
  def change

add_column :todos, :lateststart, :datetime

  end
end
