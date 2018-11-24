class PagesController < ApplicationController

  def home
    @events = Event.all
    @event = Event.new
  end
end
