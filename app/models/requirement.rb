class Requirement < ApplicationRecord
  has_many :tickets
  belongs_to :milestone

  validates :name, presence: true, uniqueness: { scope: :milestone_id }, length: { maximum: 20 }
  validates :description, length: { maximum: 200 }

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
    Rails.application.routes.url_helpers.edit_requirement_path(id:)
  end

  def breadcrumbs
    [
      *milestone.breadcrumbs,
      { name:, path: edit_path }
    ]
  end
end
