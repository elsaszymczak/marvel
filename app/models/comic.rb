class Comic < ApplicationRecord
  belongs_to :event
  has_many :comic_characters
  has_many :characters, through: :comic_characters
  validates :name, :marvel_id, uniqueness: true
end
