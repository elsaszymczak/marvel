class Comic < ApplicationRecord
  belongs_to :event
  # has_many :characters, through: :events
end
