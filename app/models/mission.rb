class Mission < ApplicationRecord
  enum status: %i[notyet doing done]

  has_many :mission_memberships, autosave: true
  has_many :users, through: :mission_memberships
end
