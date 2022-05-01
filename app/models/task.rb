class Task < ApplicationRecord
  belongs_to :requirement

  enum status: %i[notyet doing done]
  validates :name, presence: true, uniqueness: { scope: :requirement_id }, length: { maximum: 20 }
  validates :description, length: { maximum: 200 }

  def planned; end
  def actual; end
end
