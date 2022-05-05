class Milestone < ApplicationRecord
  has_many :requirements, dependent: :destroy
  has_many :tickets, through: :requirements
  belongs_to :project

  enum status: %i[notyet doing done]
  validates :name, presence: true, uniqueness: { scope: :project_id }, length: { maximum: 50 }
  validates :status, presence: true

  def count_tickets
    tickets.count
  end

  def count_tickets_by_status(status)
    tickets.filter_by_status(status).count
  end

  def count_all_tickets_by_status
    Ticket.statuses.keys.map do |s|
      count_tickets_by_status(s)
    end
  end

  def edit_path
    Rails.application.routes.url_helpers.edit_milestone_path(id:)
  end

  def breadcrumbs
    [
      *project.breadcrumbs,
      { name:, path: edit_path }
    ]
  end
end
