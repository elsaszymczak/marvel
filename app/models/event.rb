class Event < ApplicationRecord
  has_many :comics, dependent: :destroy
  has_many :characters, dependent: :destroy
  validates :name, uniqueness: true

  mount_uploader :photo, PhotoUploader
end
