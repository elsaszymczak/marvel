class Event < ApplicationRecord
  has_many :comics, dependent: :destroy
  has_many :characters, dependent: :destroy
end
