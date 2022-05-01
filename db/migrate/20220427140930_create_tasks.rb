class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :requirement, foreign_key: true
      t.string :name, null: false
      t.datetime :planned_start_date
      t.datetime :planned_end_date
      t.datetime :started_date
      t.datetime :ended_date
      t.integer :status, null: false, default: 0
      t.integer :costs, default: 1
      t.timestamps
    end
  end
end
