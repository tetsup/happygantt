class CreateMissionUserRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :mission_memberships do |t|
      t.references :mission, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :role, default: 0
      t.timestamps
    end
  end
end
