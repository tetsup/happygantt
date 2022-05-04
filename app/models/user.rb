class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :mission_user_relationships, dependent: :destroy
  has_many :missions, through: :mission_user_relationships
  has_many :projects, through: :missions
  has_many :milestones, through: :projects
  has_many :requirements, through: :milestones
  has_many :tasks, through: :requirements

  validates :name, presence: true
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }
end
