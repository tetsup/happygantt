class Project < ApplicationRecord
  has_many :project_user_relationships, autosave: true, dependent: :destroy
  has_many :users, through: :project_user_relationships
  has_many :milestones, dependent: :destroy
  belongs_to :mission

  enum status: %i[notyet doing done]
end
