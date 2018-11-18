class Character < ApplicationRecord
  belongs_to :event
  has_many :joints
  has_many :comics, through: :joints
end
