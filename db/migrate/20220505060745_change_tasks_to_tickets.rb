class ChangeTasksToTickets < ActiveRecord::Migration[6.1]
  def change
    rename_table :tasks, :tickets
  end
end
