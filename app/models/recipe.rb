class Recipe < ApplicationRecord
  belongs_to :user

  mount_uploader :photo, PhotoUploader

  validates :name, presence: true
  validates :preparation_time, numericality: { greater_than_or_equal_to: 0 }
  validates :cooking_time, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true, length: { maximum: 250 }
  validates :public, inclusion: { in: [true, false] }
end
