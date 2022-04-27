class CreateMilestones < ActiveRecord::Migration[6.1]
  def change
    create_table :milestones do |t|
      t.references :project, foreign_key: true
      t.string :name, null: false
      t.string :description
      t.datetime :due_date
      t.datetime :closed_date
      t.integer :status, null: false, default: 0
      t.timestamps
    end
    add_index :milestones, %i[project_id name], unique: true
  end
end
