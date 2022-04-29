class CreateRequirements < ActiveRecord::Migration[6.1]
  def change
    create_table :requirements do |t|
      t.references :milestone, foreign_key: true
      t.string :name, null: false
      t.string :description
      t.timestamps
    end
    add_index :requirements, %i[milestone_id name], unique: true
  end
end
