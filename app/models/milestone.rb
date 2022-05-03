class Milestone < ApplicationRecord
  has_many :requirements, dependent: :destroy
  has_many :tasks, through: :requirements
  belongs_to :project

  enum status: %i[notyet doing done]
  validates :name, presence: true, uniqueness: { scope: :project_id }, length: { maximum: 50 }

  def count_tasks
    tasks.count
  end

  def count_tasks_by_status(status)
    tasks.filter_by_status(status).count
  end

  def count_all_tasks_by_status
    Task.statuses.keys.map do |s|
      count_tasks_by_status(s)
    end
  end

  def edit_path
    Rails.application.routes.url_helpers.edit_milestone_path(id: id)
  end

  def breadcrumbs
    [
      *project.breadcrumbs,
      { name: name, path: edit_path }
    ]
  end
end
