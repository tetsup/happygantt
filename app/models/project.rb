class Project < ApplicationRecord
  has_many :project_user_relationships, autosave: true, dependent: :destroy
  has_many :users, through: :project_user_relationships
  has_many :milestones, dependent: :destroy
  belongs_to :mission

  enum status: %i[notyet doing done]
  validates :name, presence: true, uniqueness: { scope: :mission_id }, length: { maximum: 20 }
  validates :description, length: { maximum: 200 }

  def edit_path
    Rails.application.routes.url_helpers.edit_project_path(id:)
  end

  def breadcrumbs
    [
      *mission.breadcrumbs,
      { name:, path: edit_path }
    ]
  end
end
