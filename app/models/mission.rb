class Mission < ApplicationRecord
  enum status: %i[notyet doing done]

  has_many :mission_user_relationships, autosave: true
  has_many :users, through: :mission_user_relationships
end
