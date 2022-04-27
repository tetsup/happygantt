class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.references :mission, foreign_key: true
      t.string :name, null: false
      t.string :description
      t.integer :status, null: false, default: 0
      t.timestamps
    end
    add_index :projects, %i[mission_id name], unique: true
  end
end
