class MissionUserRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :mission

  enum role: %i[owner member guest]
  validates :mission_id, uniqueness: { scope: :user }
end
