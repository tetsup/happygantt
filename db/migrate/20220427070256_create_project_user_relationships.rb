class CreateProjectUserRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :project_user_relationships do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :role, default: 0
      t.timestamps
    end
  end
end
