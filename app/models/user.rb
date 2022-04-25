class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :mission_memberships, dependent: :destroy
  has_many :missions, through: :mission_memberships

  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }
end
