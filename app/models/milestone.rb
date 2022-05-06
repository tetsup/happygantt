class Milestone < ApplicationRecord
  has_many :requirements, dependent: :destroy
  has_many :tickets, through: :requirements
  has_many :tickets_notyet, -> { where(tickets: { status: :notyet }) }, class_name: 'Ticket', through: :requirements
  has_many :tickets_doing, -> { where(tickets: { status: :doing }) }, class_name: 'Ticket', through: :requirements
  has_many :tickets_done, -> { where(tickets: { status: :done }) }, class_name: 'Ticket', through: :requirements

  belongs_to :project

  enum status: %i[notyet doing done]
  validates :name, presence: true, uniqueness: { scope: :project_id }, length: { maximum: 50 }
  validates :status, presence: true

  scope :includes_tickets_by_status, -> {
    includes(:tickets_notyet).includes(:tickets_doing).includes(:tickets_done)
  }

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
