class MissionUserRelationship < ApplicationRecord
  enum role: %i[owner member guest]

  belongs_to :user
  belongs_to :mission

  validates :mission_id, uniqueness: { scope: :user }
end
