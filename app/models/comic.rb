class Comic < ApplicationRecord
  belongs_to :event
  has_many :joints
  has_many :characters, through: :joints
end
