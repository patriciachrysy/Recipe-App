class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, foreign_key: 'user_id'

  mount_uploader :photo, PhotoUploader

  validates :name, presence: true

  def is?(requested_role)
    role == requested_role.to_s
  end
end
