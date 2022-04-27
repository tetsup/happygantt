class Milestone < ApplicationRecord
  belongs_to :project

  enum status: %i[notyet doing done]
  validates :name, presence: true, uniqueness: { scope: :project_id }, length: { maximum: 50 }
end
