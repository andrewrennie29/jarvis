class Addsendmail < ActiveRecord::Migration
  def change
add_column :users, :dailysummarymail, :boolean

  end
end
