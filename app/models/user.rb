class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :mission_user_relationships, dependent: :destroy
  has_many :missions, through: :mission_user_relationships

  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }
end
