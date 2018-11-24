class Comic < ApplicationRecord
  belongs_to :event
  has_many :comic_characters, dependent: :destroy
  has_many :characters, through: :comic_characters
  validates :name, uniqueness: true

  mount_uploader :photo, PhotoUploader

end
