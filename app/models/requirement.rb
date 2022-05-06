class Requirement < ApplicationRecord
  has_many :tickets
  has_many :tickets_notyet, -> { where(status: :notyet) }, class_name: 'Ticket'
  has_many :tickets_doing, -> { where(status: :doing) }, class_name: 'Ticket'
  has_many :tickets_done, -> { where(status: :done) }, class_name: 'Ticket'
  belongs_to :milestone

  validates :name, presence: true, uniqueness: { scope: :milestone_id }, length: { maximum: 20 }
  validates :description, length: { maximum: 200 }

  scope :includes_tickets_by_status, -> {
    includes(:tickets_notyet).includes(:tickets_doing).includes(:tickets_done)
  }

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
