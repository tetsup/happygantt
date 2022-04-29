class Requirement < ApplicationRecord
  belongs_to :milestone

  validates :name, presence: true, uniqueness: { scope: :milestone_id }, length: { maximum: 20 }
  validates :description, length: { maximum: 200 }

  def count_by_status; end
end
