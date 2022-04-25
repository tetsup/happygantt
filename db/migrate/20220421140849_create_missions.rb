class CreateMissions < ActiveRecord::Migration[6.1]
  def change
    create_table :missions do |t|
      t.string :name, nullable: false
      t.string :description
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
