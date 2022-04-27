class Project < ApplicationRecord
  enum status: %i[notyet doing done]

  has_many :project_user_relationships, autosave: true, dependent: :destroy
  has_many :users, through: :project_user_relationships
  belongs_to :mission
end
