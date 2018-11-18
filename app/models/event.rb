class Event < ApplicationRecord
  has_many :comics
  has_many :characters
end
