class PagesController < ApplicationController

  def home
    @events = Event.all
    @event = Event.new

    @comics = Comic.all
    @characters = Character.all
  end
end
