class ProjectUserRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum role: %i[owner member guest]
  validates :project_id, uniqueness: { scope: :user }
end
