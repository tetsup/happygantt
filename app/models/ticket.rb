class Ticket < ApplicationRecord
  belongs_to :requirement

  enum status: %i[notyet doing done]
  validates :name, presence: true, uniqueness: { scope: :requirement_id }, length: { maximum: 20 }
  validates :description, length: { maximum: 200 }
  validates :status, presence: true

  scope :filter_by_status, ->(status) { where(status:) }

  def planned
    "#{I18n.l(planned_start_date)} - #{I18n.l(planned_end_date, format: :short)}"
  end

  def actual
    "#{I18n.l(started_date)} - #{I18n.l(ended_date, format: :short)}"
  end

  def edit_path
    Rails.application.routes.url_helpers.edit_ticket_path(id:)
  end

  def breadcrumbs
    [
      *requirement.breadcrumbs,
      { name:, path: edit_path }
    ]
  end
end
