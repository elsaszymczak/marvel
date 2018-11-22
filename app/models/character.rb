class Character < ApplicationRecord
  belongs_to :event
  has_many :comic_characters, dependent: :destroy
  has_many :comics, through: :comic_characters

  validates :name, :marvel_id, uniqueness: true

  mount_uploader :photo, PhotoUploader
end
