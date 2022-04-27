class ProjectUserRelationship < ApplicationRecord
  enum role: %i[owner member guest]

  belongs_to :user
  belongs_to :project

  validates :project_id, uniqueness: { scope: :user }
end
