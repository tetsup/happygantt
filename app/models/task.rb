class Task < ApplicationRecord
  belongs_to :requirement

  enum status: %i[notyet doing done]
  validates :name, presence: true, uniqueness: { scope: :requirement_id }, length: { maximum: 20 }
  validates :description, length: { maximum: 200 }

  def planned
    "#{I18n.l(planned_start_date)} - #{I18n.l(planned_end_date, format: :short)}"
  end
  
  def actual
    "#{I18n.l(started_date)} - #{I18n.l(ended_date, format: :short)}"
  end
end
