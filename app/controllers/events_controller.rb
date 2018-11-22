class EventsController < ApplicationController
  before_action :set_event, only: [:show, :destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def destroy
    @event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_date, :end_date, :photo, :wiki_link)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
