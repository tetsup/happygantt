class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :requirement, foreign_key: true
      t.string :name, null: false
      t.string :description
      t.date :planned_start_date
      t.date :planned_end_date
      t.date :started_date
      t.date :ended_date
      t.integer :status, null: false, default: 0
      t.integer :costs, default: 1
      t.timestamps
    end
  end
end
