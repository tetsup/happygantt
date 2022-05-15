class Mission < ApplicationRecord
  has_many :mission_user_relationships, autosave: true, dependent: :destroy
  has_many :users, through: :mission_user_relationships
  has_many :projects, dependent: :destroy
  has_many :milestones, through: :projects
  has_many :requirements, through: :milestones
  has_many :tickets, through: :requirements

  enum status: %i[notyet doing done]
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :description, length: { maximum: 200 }
  validates :status, presence: true

  def edit_path
    Rails.application.routes.url_helpers.edit_mission_path(id:)
  end

  def breadcrumbs
    [{ name:, path: edit_path }]
  end

  def jsonify_all
    as_json(
      include: { projects: {
        include: { milestones: {
          include: { requirements: {
            include: [:tickets]
          } }
        } }
      } }
    )
  end
end
