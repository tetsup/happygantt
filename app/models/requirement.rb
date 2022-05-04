class Requirement < ApplicationRecord
  has_many :tasks
  belongs_to :milestone

  validates :name, presence: true, uniqueness: { scope: :milestone_id }, length: { maximum: 20 }
  validates :description, length: { maximum: 200 }

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
    Rails.application.routes.url_helpers.edit_requirement_path(id:)
  end

  def breadcrumbs
    [
      *milestone.breadcrumbs,
      { name:, path: edit_path }
    ]
  end
end
