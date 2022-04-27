class Mission < ApplicationRecord
  has_many :mission_user_relationships, autosave: true, dependent: :destroy
  has_many :users, through: :mission_user_relationships
  has_many :projects, dependent: :destroy

  enum status: %i[notyet doing done]
end
