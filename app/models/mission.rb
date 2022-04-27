class Mission < ApplicationRecord
  enum status: %i[notyet doing done]

  has_many :mission_user_relationships, autosave: true, dependent: :destroy
  has_many :users, through: :mission_user_relationships
  has_many :projects, dependent: :destroy
end
