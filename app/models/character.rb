class Character < ApplicationRecord
  belongs_to :event
  has_many :comics, through: :events
end
